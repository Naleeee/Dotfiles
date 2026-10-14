#!/bin/bash
WS="$1"
# FOCUSED_WORKSPACE is only set when HyprSpace fires the trigger
FOCUSED="${FOCUSED_WORKSPACE:-$(hyprspace list-workspaces --focused)}"
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/helpers/icon_map.sh"

ICONS=""
while IFS= read -r app; do
  [ -z "$app" ] && continue
  __icon_map "$app"
  ICONS="$ICONS$icon_result "
done < <(hyprspace list-windows --workspace "$WS" --format '%{app-name}' | sort -u)

if [ "$WS" = "$FOCUSED" ]; then
  STYLE=(background.drawing=on background.color=$BLUE icon.color=$BASE label.color=$BASE)
elif [ -n "$ICONS" ]; then
  STYLE=(background.drawing=off icon.color=$SUBTEXT label.color=$TEXT)
else
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ -n "$ICONS" ]; then
  sketchybar --set "$NAME" drawing=on "${STYLE[@]}" label.drawing=on label="${ICONS% }"
else
  sketchybar --set "$NAME" drawing=on "${STYLE[@]}" label.drawing=off
fi
