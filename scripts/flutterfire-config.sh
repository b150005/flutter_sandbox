#!/bin/bash

# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects
# https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/

set -e

if [[ -z "$1" ]]; then
    echo "❌ Error: No environment specified."
    echo "📖 Usage: flutterfire-config.sh <environment>"
    echo "🎯 Available environments: dev, stg, prod"
    exit 1
fi

BASE_BUNDLE_ID="com.example.flutterSandbox"
BASE_PACKAGE_NAME="com.example.flutter_sandbox"

case $1 in
  dev)
    ENVIRONMENT="development"
    CAPITALIZED_ENVIRONMENT="Development"
    FIREBASE_PROJECT_ID="flutter-sandbox-dev-b2067"
    BUNDLE_ID="$BASE_BUNDLE_ID.development"
    PACKAGE_NAME="$BASE_PACKAGE_NAME.development"
    ;;
  stg)
    ENVIRONMENT="staging"
    CAPITALIZED_ENVIRONMENT="Staging"
    FIREBASE_PROJECT_ID="flutter-sandbox-stg"
    BUNDLE_ID="$BASE_BUNDLE_ID.staging"
    PACKAGE_NAME="$BASE_PACKAGE_NAME.staging"
    ;;
  prod)
    ENVIRONMENT="production"
    CAPITALIZED_ENVIRONMENT="Production"
    FIREBASE_PROJECT_ID="flutter-sandbox-ebfb7"
    BUNDLE_ID="$BASE_BUNDLE_ID"
    PACKAGE_NAME="$BASE_PACKAGE_NAME"
    ;;
  *)
    echo "❌ Error: Invalid environment specified."
    echo "📖 Usage: ./flutterfire-config.sh <environment>"
    echo "🎯 Available environments:"
    echo "   • dev  - Development environment"
    echo "   • stg  - Staging environment" 
    echo "   • prod - Production environment"
    exit 1
    ;;
esac

echo "🔥 Starting FlutterFire configuration for $ENVIRONMENT environment..."
echo ""

flutterfire config \
  --project="$FIREBASE_PROJECT_ID" \
  --out="lib/core/config/firebase/firebase_options_$ENVIRONMENT.dart" \
  --ios-bundle-id="$BUNDLE_ID" \
  --ios-out="ios/$CAPITALIZED_ENVIRONMENT/GoogleService-Info.plist" \
  --macos-bundle-id="$BUNDLE_ID" \
  --macos-out="macos/$CAPITALIZED_ENVIRONMENT/GoogleService-Info.plist" \
  --android-package-name="$PACKAGE_NAME" \
  --android-out="android/app/src/$ENVIRONMENT/google-services.json"

echo ""
echo "🎉 FlutterFire configuration completed!"