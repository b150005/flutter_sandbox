#!/bin/bash

# Investigates packages that cannot be upgraded due to dependency version conflicts.
# Outputs results in a table format with the following columns:
#   Package Name | Latest | Upgradable | Current | Conflicting Packages
#
# Usage:
#   ./check-non-upgradable-packages.sh           # show up to 1 conflicting package
#   ./check-non-upgradable-packages.sh --all     # show all conflicting packages

set -euo pipefail

SHOW_ALL=false
for arg in "$@"; do
  if [[ "$arg" == "--all" ]]; then
    SHOW_ALL=true
  fi
done

# --- Dependency checks ---

if ! command -v flutter &>/dev/null; then
  echo "❌ Error: flutter command not found." >&2
  exit 1
fi

if ! command -v python3 &>/dev/null; then
  echo "❌ Error: python3 command not found." >&2
  exit 1
fi

# --- Working directory ---

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

if [[ ! -f "$PROJECT_DIR/pubspec.yaml" ]]; then
  echo "❌ Error: pubspec.yaml not found in $PROJECT_DIR" >&2
  exit 1
fi

echo "🔍 Analyzing non-upgradable packages in: $PROJECT_DIR"
echo ""

cd "$PROJECT_DIR"

# --- Collect data ---

OUTDATED_JSON=$(flutter pub outdated --json 2>/dev/null | grep -v "^export plugin")
DEPS_JSON=$(flutter pub deps --json 2>/dev/null | grep -v "^export plugin")

# --- Analyze and print table ---

python3 << PYEOF
import json
import re
import sys
import urllib.request

SHOW_ALL = "${SHOW_ALL}" == "true"
MAX_DISPLAY = None if SHOW_ALL else 1

# ------------------------------------------------------------------ #
# Semver constraint checker (pure stdlib, no packaging module needed) #
# ------------------------------------------------------------------ #

def version_tuple(v: str) -> tuple:
    """
    Parse a Dart/pub semver-like version string into a comparable tuple.
    - Build metadata (+build) is stripped and ignored (semver spec).
    - Pre-release (e.g. 1.0.0-dev.8) sorts lower than the release (1.0.0).
    """
    v = v.strip()
    # Strip build metadata (+...) before any other processing
    if "+" in v:
        v = v.split("+", 1)[0]
    pre_val = 0
    if "-" in v:
        base, pre_part = v.split("-", 1)
        nums = re.findall(r'\d+', pre_part)
        pre_val = -10000 + int(nums[-1]) if nums else -10000
    else:
        base = v
    parts = []
    for p in base.split("."):
        try:
            parts.append(int(p))
        except ValueError:
            parts.append(0)
    while len(parts) < 3:
        parts.append(0)
    return tuple(parts[:3]) + (pre_val,)

def satisfies(installed_ver: str, constraint_str: str) -> bool:
    """Return True if installed_ver satisfies the pub version constraint."""
    if not isinstance(constraint_str, str):
        return True  # sdk dep ({sdk: flutter}) or unrecognized form
    cs = constraint_str.strip()
    iv = version_tuple(installed_ver)

    # Exact pin: no operators (e.g. "3.3.1", "1.0.0-dev.9")
    if not re.search(r'[<>=^!]', cs):
        return iv == version_tuple(cs)

    # Caret: ^X.Y.Z
    #   X > 0  → >=X.Y.Z <(X+1).0.0
    #   X == 0 → >=0.Y.Z <0.(Y+1).0   (Dart pub semver behaviour)
    m = re.match(r'^\^(\d[\d.\-]*)$', cs)
    if m:
        lo = version_tuple(m.group(1))
        if lo[0] > 0:
            hi = (lo[0] + 1, 0, 0, 0)
        else:
            hi = (0, lo[1] + 1, 0, 0)
        return lo <= iv < hi

    # Compound ranges: >=X <Y, >=X <=Y, >X, etc.
    ops = re.findall(r'([><=!]+)\s*([\d][\d.\-]*)', cs)
    if ops:
        for op, ver in ops:
            v = version_tuple(ver)
            if op == ">=" and not (iv >= v): return False
            if op == ">"  and not (iv >  v): return False
            if op == "<=" and not (iv <= v): return False
            if op == "<"  and not (iv <  v): return False
            if op == "==" and not (iv == v): return False
            if op == "!=" and not (iv != v): return False
        return True

    return True  # unrecognized constraint — assume satisfied

# ------------------------------------------------------------------ #
# Load data                                                           #
# ------------------------------------------------------------------ #

outdated_data = json.loads("""${OUTDATED_JSON}""")
deps_data     = json.loads("""${DEPS_JSON}""")

packages = deps_data.get("packages", [])

# Map: package name → currently installed version
installed: dict[str, str] = {
    p["name"]: p["version"]
    for p in packages
    if p.get("kind") != "root" and "version" in p
}

# ------------------------------------------------------------------ #
# pub.dev API helper                                                  #
# ------------------------------------------------------------------ #

_pubspec_cache: dict[tuple, dict] = {}

def fetch_pubspec(name: str, version: str) -> dict:
    key = (name, version)
    if key in _pubspec_cache:
        return _pubspec_cache[key]
    url = f"https://pub.dev/api/packages/{name}/versions/{version}"
    try:
        with urllib.request.urlopen(url, timeout=8) as r:
            data = json.loads(r.read())
        result = data.get("pubspec", {})
    except Exception:
        result = {}
    _pubspec_cache[key] = result
    return result

# ------------------------------------------------------------------ #
# Conflict detection                                                  #
#                                                                     #
# For each non-upgradable package P, find every installed package Q  #
# that depends on P and whose version constraint on P excludes P's   #
# latest version.  Those Q packages are the "conflicting packages".  #
# ------------------------------------------------------------------ #

# Build reverse dependency map: pkg → list of installed pkgs that depend on it
reverse_deps: dict[str, list[str]] = {}
for p in packages:
    for dep in p.get("dependencies", []):
        reverse_deps.setdefault(dep, []).append(p["name"])

def find_conflicting_packages(
    pkg_name: str, latest_ver: str, limit: int | None = None
) -> list[tuple[str, str]]:
    """
    For each installed package Q that depends on pkg_name, check whether
    Q's version constraint on pkg_name excludes latest_ver.
    Returns sorted list of (Q_name, constraint) pairs.

    If limit is given, stops as soon as that many conflicts are found
    (avoids unnecessary pub.dev fetches when only a partial result is needed).
    """
    result: dict[str, str] = {}
    for parent_name in sorted(reverse_deps.get(pkg_name, [])):
        if limit is not None and len(result) >= limit:
            break
        parent_ver = installed.get(parent_name)
        if not parent_ver:
            continue
        parent_pubspec = fetch_pubspec(parent_name, parent_ver)
        constraint = parent_pubspec.get("dependencies", {}).get(pkg_name)
        if not isinstance(constraint, str):
            continue
        if not satisfies(latest_ver, constraint):
            result[parent_name] = constraint

    return sorted(result.items())

# ------------------------------------------------------------------ #
# Filter non-upgradable packages                                      #
# ------------------------------------------------------------------ #

not_upgradable = []
for pkg in outdated_data.get("packages", []):
    cur = pkg.get("current", {}).get("version", "")
    upg = pkg.get("upgradable", {}).get("version", "")
    lat = pkg.get("latest", {}).get("version", "")
    if upg == cur and lat != cur:
        not_upgradable.append(pkg)

if not not_upgradable:
    print("✅ All packages are up-to-date or upgradable.")
    sys.exit(0)

# ------------------------------------------------------------------ #
# Build rows (fetch pub.dev in order; could be parallelised if slow) #
# ------------------------------------------------------------------ #

def fmt_conflict(pkg: str, constraint: str) -> str:
    return f"{pkg} ({constraint})"

print(f"📦 Fetching conflict info for {len(not_upgradable)} packages from pub.dev ...")
print("")

rows: list[tuple[str, str, str, str, str]] = []
for pkg in not_upgradable:
    name           = pkg["package"]
    latest_ver     = pkg.get("latest", {}).get("version", "-")
    upgradable_ver = pkg.get("upgradable", {}).get("version", "-")
    current_ver    = pkg.get("current", {}).get("version", "-")

    conflicts = find_conflicting_packages(name, latest_ver, limit=MAX_DISPLAY)

    if not conflicts:
        causes_str = "-"
    else:
        causes_str = ", ".join(fmt_conflict(p, c) for p, c in conflicts)

    rows.append((name, latest_ver, upgradable_ver, current_ver, causes_str))

# ------------------------------------------------------------------ #
# Print table                                                         #
# ------------------------------------------------------------------ #

COL_HEADERS = ("Package Name", "Latest", "Upgradable", "Current", "Conflicting Packages")

col_widths = [len(h) for h in COL_HEADERS]
for row in rows:
    for i, cell in enumerate(row):
        col_widths[i] = max(col_widths[i], len(cell))

def fmt_row(cells: tuple) -> str:
    return "| " + " | ".join(c.ljust(col_widths[i]) for i, c in enumerate(cells)) + " |"

separator = "+-" + "-+-".join("-" * w for w in col_widths) + "-+"

print(separator)
print(fmt_row(COL_HEADERS))
print(separator)
for row in rows:
    print(fmt_row(row))
print(separator)
print("")
if SHOW_ALL:
    print("💡 Showing all conflicting packages (--all).")
else:
    print("💡 Showing up to 1 conflicting package. Use --all to see all.")
print("   'Conflicting Packages' = packages that constrain the Package Name below its latest version.")
PYEOF
