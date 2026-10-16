#!/usr/bin/env bash
# Claude Code hook target: tags the calling pane's tmux window with @claude_state (done|waiting).
[ -n "$TMUX_PANE" ] || exit 0

case "$1" in
  clear) tmux set -wqu -t "$TMUX_PANE" @claude_state ;;
  clear-waiting)
    [ "$(tmux show -wqv -t "$TMUX_PANE" @claude_state)" = waiting ] && tmux set -wqu -t "$TMUX_PANE" @claude_state ;;
  *) tmux set -wq -t "$TMUX_PANE" @claude_state "$1" ;;
esac 2>/dev/null

for client in $(tmux list-clients -F '#{client_name}'); do
  tmux refresh-client -S -t "$client"
done 2>/dev/null
exit 0
