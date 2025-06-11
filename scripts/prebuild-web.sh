#!/bin/bash

# Script to generate index.html for web based on environment

set -e

ENVIRONMENT_FILE="$1"
OUTPUT_FILE="web/index.html"
TEMPLATE_FILE="web/index.html.template"

if [[ -z "$ENVIRONMENT_FILE" ]]; then
  echo "❌ Error: No environment file specified."
  echo "📖 Usage: ./build-web.sh <environment.env>"
  exit 1
fi

if [[ ! -f "$ENVIRONMENT_FILE" ]]; then
  echo "❌ Environment file not found: $ENVIRONMENT_FILE"
  exit 1
fi

if [[ ! -f "$TEMPLATE_FILE" ]]; then
  echo "❌ Template file not found: $TEMPLATE_FILE"
  exit 1
fi

echo "🔍 Processing environment file for Web: $ENVIRONMENT_FILE"
echo "📄 Template: $TEMPLATE_FILE"
echo "📄 Output: $OUTPUT_FILE"

cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

# 一時ファイルを使って環境変数を保存
temp_env_file=$(mktemp)
trap "rm -f $temp_env_file" EXIT

echo ""
echo "🔍 Parsing environment variables..."

while IFS= read -r line; do
  echo "   Decoded entry: '$line'"

  trimmed_line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  if [[ -z "$trimmed_line" ]]; then
    echo "   ⚠️ Skipping empty line"
    continue
  fi

  if [[ "$trimmed_line" =~ ^[[:space:]]*# ]]; then
    echo "   💬 Skipping comment: '$trimmed_line'"
    continue
  fi

  # key=value 形式の検証
  if [[ ! "$trimmed_line" =~ ^[^=]+= ]]; then
    echo "   ⚠️ Skipping invalid entry (no '=' found): '$trimmed_line'"
    continue
  fi

  # key=value 形式で分割（値に=が含まれる場合も考慮）
  key="${trimmed_line%%=*}"
  value="${trimmed_line#*=}"

  # key の前後スペース除去
  key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  # 空の key をスキップ
  if [[ -z "$key" ]]; then
    echo "   ⚠️ Skipping entry with blank key: '$trimmed_line'"
    continue
  fi

  # key にスペースが含まれている場合をスキップ
  if [[ "$key" =~ [[:space:]] ]]; then
    echo "   ⚠️ Skipping entry with space in key: '$key'"
    continue
  fi

  # 値の前後スペース除去
  value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  # Flutter 内部変数をスキップ
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

  # 一時ファイルに保存（連想配列の代替）
  echo "$key|$value" >> "$temp_env_file"
  echo "   ✅ Parsed: '$key' = '$value'"
done < "$ENVIRONMENT_FILE"

echo ""
echo "🔄 Applying environment variables to template..."

# 一時ファイルから読み込んで置換
while IFS='|' read -r key value; do
  if [[ -n "$key" && -n "$value" ]]; then
    # エスケープ処理（sedで安全に使えるように）
    escaped_value=$(printf '%s\n' "$value" | sed 's/[[\.*^$()+?{|]/\\&/g')

    # テンプレート内の {{key}} を値で置換
    if sed -i.bak "s|{{$key}}|$escaped_value|g" "$OUTPUT_FILE" 2>/dev/null; then
      # macOS対応（.bakファイルを削除）
      rm -f "$OUTPUT_FILE.bak"
    else
      # Linux対応
      sed -i "s|{{$key}}|$escaped_value|g" "$OUTPUT_FILE"
    fi
    echo "   🔄 Replaced {{$key}}"
  fi
done < "$temp_env_file"

echo ""
echo "✅ Web build completed successfully!"
echo "🎯 Generated file: $OUTPUT_FILE"
echo ""
echo "💡 Tip: You can now run 'flutter run -d chrome' to start your web app."