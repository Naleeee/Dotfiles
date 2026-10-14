#!/bin/bash
# Same "used" definition as Activity Monitor: active + wired + compressed
sketchybar --set "$NAME" label="$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" '
  /page size of/ { pg = $8 }
  /Pages active/ { a = $3 }
  /Pages wired down/ { w = $4 }
  /Pages occupied by compressor/ { c = $5 }
  END { printf "%d%%", (a + w + c) * pg * 100 / total }')"
