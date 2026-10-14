#!/bin/bash
# $INFO is only set by front_app_switched; the first run at startup has none
APP="${INFO:-$(osascript -e 'tell application "System Events" to get displayed name of first process whose frontmost is true')}"
source "$CONFIG_DIR/helpers/icon_map.sh"
__icon_map "$APP"
sketchybar --set "$NAME" icon="$icon_result" label="$APP"
