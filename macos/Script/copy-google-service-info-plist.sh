#!/bin/bash

# This script copies the appropriate Firebase configuration file based on the environment.

# Check if CAPITALIZED_APP_ENV is available
if [ -z "${CAPITALIZED_APP_ENV}" ]; then
    echo "Error: Environment variable 'CAPITALIZED_APP_ENV' is not set."
    echo "Make sure the xcconfig file containing dart-define variables is properly included in the build configuration."
    echo "Expected variables should be generated from --dart-define-from-file."
    exit 1
fi

# Define source and destination paths
SOURCE_FILE="${SRCROOT}/${CAPITALIZED_APP_ENV}/GoogleService-Info.plist"
DEST_FILE="${SRCROOT}/Runner/GoogleService-Info.plist"

echo "🔍 Firebase Configuration Setup:"
echo "   Environment: ${CAPITALIZED_APP_ENV}"
echo "   Source: ${SOURCE_FILE}"
echo "   Destination: ${DEST_FILE}"

# Check if source file exists
if [ ! -f "${SOURCE_FILE}" ]; then
    echo "❌ Error: Firebase configuration file not found."
    echo "   Expected location: ${SOURCE_FILE}"
    echo "   Please ensure the GoogleService-Info.plist file exists for the '${CAPITALIZED_APP_ENV}' environment."
    echo ""
    echo "   Directory structure should be:"
    echo "   ${SRCROOT}/"
    echo "   ├── Development/"
    echo "   │   └── GoogleService-Info.plist"
    echo "   ├── Staging/"
    echo "   │   └── GoogleService-Info.plist"
    echo "   └── Production/"
    echo "       └── GoogleService-Info.plist"
    exit 1
fi

# Create destination directory if it doesn't exist
DEST_DIR=$(dirname "${DEST_FILE}")
if [ ! -d "${DEST_DIR}" ]; then
    echo "⚠️ Warning: Destination directory does not exist. Creating: ${DEST_DIR}"
    mkdir -p "${DEST_DIR}"
fi

# Copy the file
if cp "${SOURCE_FILE}" "${DEST_FILE}"; then
    echo "✅ Successfully copied Firebase configuration for ${CAPITALIZED_APP_ENV} environment"
    echo "   ${SOURCE_FILE} -> ${DEST_FILE}"
else
    echo "❌ Error: Failed to copy Firebase configuration file."
    echo "   Source: ${SOURCE_FILE}"
    echo "   Destination: ${DEST_FILE}"
    echo "   Please check file permissions and disk space."
    exit 1
fi

# Verify the copied file
if [ -f "${DEST_FILE}" ]; then
    echo "✅ Firebase configuration file successfully installed."
    # Optional: Show file size for verification
    FILE_SIZE=$(stat -f%z "${DEST_FILE}" 2>/dev/null || stat -c%s "${DEST_FILE}" 2>/dev/null || echo "unknown")
    echo "   File size: ${FILE_SIZE} bytes"
else
    echo "❌ Error: Firebase configuration file was not properly copied."
    echo "   Expected file: ${DEST_FILE}"
    exit 1
fi

echo "🔥 Firebase configuration setup completed successfully."