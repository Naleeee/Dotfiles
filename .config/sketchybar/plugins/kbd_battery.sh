#!/bin/bash
LEVEL="$("$HOME/.cache/sketchybar/blebattery" 2>/dev/null | head -1 | cut -f2)"

if [ -n "$LEVEL" ]; then
  sketchybar --set "$NAME" drawing=on label="${LEVEL}%"
else
  sketchybar --set "$NAME" drawing=off
fi
