#!/bin/bash
source "$CONFIG_DIR/colors.sh"
read -r STATE COUNT < <(system_profiler SPBluetoothDataType -json 2>/dev/null | python3 -c '
import sys, json
d = json.load(sys.stdin)["SPBluetoothDataType"][0]
print(d.get("controller_properties", {}).get("controller_state", "off"), len(d.get("device_connected", [])))')

if [ "$STATE" != "attrib_on" ]; then
  sketchybar --set "$NAME" icon=󰂲 icon.color=$OVERLAY label.drawing=off
elif [ "$COUNT" -gt 0 ]; then
  sketchybar --set "$NAME" icon= icon.color=$BLUE label.drawing=on label="$COUNT"
else
  sketchybar --set "$NAME" icon= icon.color=$BLUE label.drawing=off
fi
