#!/bin/bash

# Script to safely terminate all Firebase emulator processes

echo '🔥 Stopping Firebase Emulators...'

PORTS=(
  4000
  5001
  5002
  8080
  8085
  9000
  9099
  9199
  9299
  9399
  9499
)

SERVICES=(
  "UI"
  "Functions"
  "Hosting"
  "Firestore"
  "Pub/Sub"
  "Realtime Database"
  "Auth"
  "Storage"
  "Eventarc"
  "Data Connect"
  "Tasks"
)

# Process each service
for i in "${!PORTS[@]}"; do
  PORT=${PORTS[$i]}
  SERVICE=${SERVICES[$i]}

  echo -n "[$SERVICE:$PORT] "

  # Check for running processes
  PIDS=$(lsof -ti:$PORT 2>/dev/null)

  if [ -n "$PIDS" ]; then
    # Try graceful shutdown first
    echo $PIDS | xargs kill -TERM 2>/dev/null && sleep 0.5

    # Check if any processes remain
    REMAINING=$(lsof -ti:$PORT 2>/dev/null)

    if [ -n "$REMAINING" ]; then
      # Force kill if necessary
      echo $REMAINING |
        xargs kill -9 2>/dev/null && \
        echo "✓ Force killed"
    else
      echo "✓ Gracefully stopped"
    fi
  else
    echo "○ Not running"
  fi
done

echo ''
echo '✅ All Firebase emulator ports processed.'