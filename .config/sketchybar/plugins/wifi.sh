#!/bin/bash
source "$CONFIG_DIR/colors.sh"
SSID="$(ipconfig getsummary en0 | awk -F' SSID : ' '/ SSID : /{print $2}')"

if [ -n "$SSID" ]; then
  sketchybar --set "$NAME" icon= icon.color=$SAPPHIRE
elif networksetup -getairportpower en0 | grep -q "On"; then
  sketchybar --set "$NAME" icon= icon.color=$OVERLAY
else
  sketchybar --set "$NAME" icon=󰖪 icon.color=$OVERLAY
fi
