#!/bin/bash

# this file is added to 'Run Script' in build phases.

# remove this custom implmenentation when flutter fix following issue:
# https://github.com/flutter/flutter/issues/139289

# https://github.com/theachoem/storypad/blob/develop/ios/scripts/extract_dart_defines.sh

OUTPUT_FILE="${SRCROOT}/Flutter/ephemeral/Flutter-Env.xcconfig"

# Echo empty to file.
>"$OUTPUT_FILE"

echo "🔍 Processing dart-defines for macOS..."

function decode_url() { 
  local input="$1"
  if ! echo "$input" | base64 --decode 2>/dev/null; then
    return 1
  fi
}

if [[ -z "$DART_DEFINES" ]]; then
  echo "🔍 No dart-defines property found"
  exit 0
fi

echo "🔍 Raw dart-defines: $DART_DEFINES"

IFS=',' read -r -a define_items <<< "$DART_DEFINES"

for index in "${!define_items[@]}"; do
  entry="${define_items[$index]}"

  if ! item=$(decode_url "$entry"); then
    echo "   ❌ Failed to decode Base64 entry '$entry': Invalid Base64"
    continue
  fi

  echo "   Decoded entry: '$item'"

  trimmed_item=$(echo "$item" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  if [[ -z "$trimmed_item" ]]; then
    echo "   ⚠️ Skipping empty line"
    continue
  fi

  if [[ "$trimmed_item" =~ ^[[:space:]]*# ]]; then
    echo "   💬 Skipping comment: '$trimmed_item'"
    continue
  fi

  if [[ ! "$trimmed_item" =~ ^[^=]+= ]]; then
    echo "   ⚠️ Skipping invalid entry (no '=' found): '$trimmed_item'"
    continue
  fi

  key="${trimmed_item%%=*}"
  value="${trimmed_item#*=}"

  key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  if [[ -z "$key" ]]; then
    echo "   ⚠️ Skipping entry with blank key: '$trimmed_item'"
    continue
  fi

  if [[ "$key" =~ [[:space:]] ]]; then
    echo "   ⚠️ Skipping entry with space in key: '$key'"
    continue
  fi

  value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  # Flutter内部変数をスキップ
  lowercase_key=$(echo "$key" | tr '[:upper:]' '[:lower:]')
  if [[ $lowercase_key == flutter* ]]; then
    echo "   🚫 Skipping Flutter internal variable: '$key'"
    continue
  fi

  # 値のクォート除去
  if [[ "$value" =~ ^\".*\"$ ]]; then
    value="${value:1:-1}"
  elif [[ "$value" =~ ^\'.*\'$ ]]; then
    value="${value:1:-1}"
  fi

  echo "$key=$value" >> "$OUTPUT_FILE"
  echo "   ✅ Parsed: '$key' = '$value'"
done