#!/bin/bash

# Create (or reopen) a ticket worktree and give it a tmux window in the current session.
# Usage: WtTicket.sh <branch> [base-branch]
set -eu

branch=${1:?usage: WtTicket.sh <branch> [base-branch]}
base=${2:-}
[ -n "${TMUX:-}" ] || { echo "run inside tmux" >&2; exit 1; }

key=$(printf '%s' "$branch" | grep -oE '[A-Za-z]+-[0-9]+' | head -1 | tr '[:lower:]' '[:upper:]')
key=${key:-$(printf '%s' "$branch" | tr '/' '-')}
session=$(tmux display-message -p '#{session_name}')

create=--create
if git show-ref --verify -q "refs/heads/$branch" || git show-ref --verify -q "refs/remotes/origin/$branch"; then
  create=
fi

exec wt switch $create ${base:+--base "$base"} "$branch" --no-cd \
  -x sh -- -c '
    id=$(tmux new-window -P -F "#{window_id}" -t "$1:" -n "$2" -c "$3")
    tmux send-keys -t "$id" nvim Enter
    tmux switch-client -t "$1"
    tmux select-window -t "$id"
    wt -C "$3" config state vars set "window=$id" >/dev/null
  ' sh "$session" "$key" "{{ worktree_path }}"
