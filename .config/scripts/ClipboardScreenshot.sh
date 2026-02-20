#!/bin/bash
# Save macOS clipboard image to a file for use with opencode.
# Usage: clip [optional_name]
# After Cmd+Ctrl+Shift+4, run this to save the screenshot as a file.

DIR="$HOME/Screenshots"
mkdir -p "$DIR"

NAME="${1:-screenshot-$(date +%Y%m%d-%H%M%S)}"
FILE="$DIR/$NAME.png"

if ! pngpaste "$FILE" 2>/dev/null; then
  echo "No image in clipboard. Take a screenshot first (Cmd+Ctrl+Shift+4)."
  echo "Requires pngpaste: brew install pngpaste"
  exit 1
fi

echo "$FILE"
