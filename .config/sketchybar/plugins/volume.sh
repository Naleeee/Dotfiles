#!/bin/bash
case "$SENDER" in
  mouse.exited.global) sketchybar --set "$NAME" popup.drawing=off; exit 0 ;;
  mouse.clicked) osascript -e "set volume output volume $PERCENTAGE"; exit 0 ;;
  volume_change) VOLUME="$INFO" ;;
  *) VOLUME="$(osascript -e 'output volume of (get volume settings)')" ;;
esac

case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾" ;;
  [3-5][0-9]) ICON="󰖀" ;;
  [1-9]|[1-2][0-9]) ICON="󰕿" ;;
  *) ICON="󰖁" ;;
esac

sketchybar --set volume icon="$ICON" label="${VOLUME}%" \
  --set volume.slider slider.percentage="$VOLUME"
