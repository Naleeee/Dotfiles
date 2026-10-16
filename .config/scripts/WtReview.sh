#!/bin/bash

# Review a PR in its own worktree: tuicr on the left, Claude on the right, in the Dash session.
# Usage: WtReview.sh <repo-path> <pr-number>   (wired to the D key in gh-dash)
set -eu

repo=${1:?usage: WtReview.sh <repo-path> <pr-number>}
pr=${2:?usage: WtReview.sh <repo-path> <pr-number>}
repo=${repo/#\~/$HOME}

session=Dash
tmux has-session -t "=$session" 2>/dev/null || session=$(tmux display-message -p '#{session_name}')

prompt="/code-review-and-quality PR#$pr. Ensure the review standards match @$HOME/.claude/CODE_REVIEW_STANDARDS.md. Post recommended changed as 1 line for the file that need edition with its full path, and another line with the line(s) where to post the comment follow by a short 1 line comment to post for the change always in english"

exec wt -C "$repo" switch "pr:$pr" --no-cd \
  -x sh -- -c '
    id=$(tmux new-window -P -F "#{window_id}" -t "$1:" -n "PR-$2" -c "$3" "$HOME/.config/scripts/TuicrPrSince.sh $2")
    tmux split-window -h -t "$id" -c "$3" "claude '"'"'$4'"'"'"
    tmux switch-client -t "$1"
    tmux select-window -t "$id"
    [ -n "$(wt -C "$3" config state vars get window 2>/dev/null || true)" ] || wt -C "$3" config state vars set "window=$id" >/dev/null
  ' sh "$session" "$pr" "{{ worktree_path }}" "$prompt"
