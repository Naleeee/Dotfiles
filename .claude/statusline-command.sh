#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir=$(basename "$cwd")

model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

# dir segment
printf "\033[0;34m %s\033[0m" "$dir"

# model segment
printf "  \033[0;36m%s\033[0m" "$model"

# context usage segment
if [ -n "$used" ]; then
  printf "  \033[0;32mctx: $(printf '%.0f' "$used")%%\033[0m"
fi

# 5h rate-limit segment
if [ -n "$five_h" ]; then
  printf "  \033[0;35m5h: $(printf '%.0f' "$five_h")%%\033[0m"
fi

# session cost segment
if [ -n "$cost" ] && [ "$(printf '%.2f' "$cost")" != "0.00" ]; then
  printf "  \033[0;33m\$$(printf '%.2f' "$cost")\033[0m"
fi
