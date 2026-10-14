#!/bin/bash
IFS=$'\t' read -r ID SOURCE_NAME < <("$HOME/.cache/sketchybar/kbdlayout")
case "$ID" in
  *AZERTY*) LAYOUT="AZERTY" ;;
  com.apple.keylayout.ABC|com.apple.keylayout.US) LAYOUT="QWERTY" ;;
  *) LAYOUT="$SOURCE_NAME" ;;
esac
sketchybar --set "$NAME" label="$LAYOUT"
