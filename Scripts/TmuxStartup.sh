#!/bin/bash
tmux new -d -s Work
tmux rename-window Config
tmux set pane-border-status top

# # Open a window for each parameter given
for name in "$@"; do
  tmux new-window -n "$name"
  tmux set pane-border-status top
done

tmux attach -t Work

