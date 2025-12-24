# Tmux Configuration

A customized Tmux setup with Catppuccin theme, floating windows, and productivity plugins for efficient terminal session management.

---

## Table of Contents

- [Overview](#overview)
- [Theme](#theme)
- [Keybindings](#keybindings)
- [Plugins](#plugins)
- [Features](#features)
- [Configuration Details](#configuration-details)
- [Installation](#installation)

---

## Overview

This Tmux configuration provides:

- **Catppuccin Mocha** theme matching the rest of the environment
- **Top status bar** with session info and directory
- **Floating terminal** windows via tmux-floax
- **FZF integration** for URLs and links
- **Vi mode** for copy/navigation
- **Mouse support** enabled
- **1-indexed windows** (more natural numbering)

### Prefix Key

The prefix key is **`Ctrl+A`** (not the default `Ctrl+B`).

---

## Theme

### Catppuccin Mocha

Custom-styled Catppuccin theme with:

- Session name on the left
- Current directory on the right
- Window tabs with zoom indicator
- Purple accent borders on active pane

```conf
set -g @catppuccin_flavour 'mocha'
set -g @catppuccin_window_left_separator " "
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_status_modules_right "directory"
set -g @catppuccin_status_modules_left "session"
```

### Pane Borders

```conf
set -g pane-active-border-style 'fg=#cba6f7,bg=default'  # Purple active
set -g pane-border-style 'fg=#313244,bg=default'          # Subtle inactive
```

---

## Keybindings

### Prefix: `Ctrl+A`

### Session/Window Management

| Keybinding | Action |
|------------|--------|
| `Prefix + c` | Create new window |
| `Prefix + n` | Next window |
| `Prefix + p` | Previous window |
| `Prefix + &` | Kill window |
| `Prefix + ,` | Rename window |
| `Prefix + w` | List windows |
| `Prefix + d` | Detach session |
| `Prefix + s` | List sessions |

### Pane Management

| Keybinding | Action |
|------------|--------|
| `Prefix + %` | Split vertically |
| `Prefix + "` | Split horizontally |
| `Prefix + x` | Kill pane |
| `Prefix + z` | Toggle pane zoom |
| `Prefix + {` | Move pane left |
| `Prefix + }` | Move pane right |
| `Prefix + Arrow` | Navigate panes |

### Special Features

| Keybinding | Action |
|------------|--------|
| `Alt + P` | Toggle floating terminal (floax) |
| `Prefix + u` | Open FZF link picker |
| `Prefix + I` | Install plugins (TPM) |
| `Prefix + U` | Update plugins (TPM) |

### Vi Mode (Copy)

| Keybinding | Action |
|------------|--------|
| `Prefix + [` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank selection |
| `q` | Exit copy mode |

---

## Plugins

Managed with [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm):

| Plugin | Description |
|--------|-------------|
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | System clipboard integration |
| [tmux-battery](https://github.com/tmux-plugins/tmux-battery) | Battery status display |
| [catppuccin-tmux](https://github.com/catppuccin/tmux) | Catppuccin theme |
| [tmux-floax](https://github.com/omerxx/tmux-floax) | Floating terminal windows |
| [tmux-fzf](https://github.com/sainnhe/tmux-fzf) | FZF integration |
| [tmux-fzf-links](https://github.com/alberti42/tmux-fzf-links) | FZF URL/file picker |
| [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) | Quick text selection |

---

## Features

### Floating Terminal (Floax)

Press `Alt + P` to toggle a floating terminal window:

```conf
set -g @floax-bind '-n M-p'
set -g @floax-width '90%'
set -g @floax-height '90%'
```

### FZF Link Picker

Press `Prefix + u` to open FZF and select URLs/files from terminal output:

```conf
set-option -g @fzf-links-key 'u'
set-option -g @fzf-links-browser-open-cmd "xdg-open '%url'"
set-option -g @fzf-links-editor-open-cmd "tmux new-window -n 'edit' nvim +%line '%file'"
```

### Mouse Support

- Click to select pane
- Drag to resize panes
- Scroll to navigate history
- Click on tabs to switch windows

---

## Configuration Details

### General Settings

```conf
set -g prefix ^A                    # Prefix key
set -g base-index 1                 # Start window numbering at 1
set -g detach-on-destroy off        # Don't exit on session close
set -g escape-time 0                # No escape delay
set -g history-limit 1000000        # Large history
set -g renumber-windows on          # Renumber on close
set -g set-clipboard on             # System clipboard
set -g status-position top          # Status bar at top
setw -g mode-keys vi                # Vi mode
set -g mouse on                     # Mouse support
```

### True Color Support

```conf
set -g default-terminal "screen-256color"
set-option -sa terminal-overrides ",xterm-kitty:RGB"
```

---

## Installation

### Install Tmux

```bash
# Arch/Manjaro
sudo pacman -S tmux

# Ubuntu/Debian
sudo apt install tmux

# macOS
brew install tmux
```

### Install TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Install Plugins

1. Start tmux: `tmux`
2. Press `Prefix + I` to install plugins
3. Reload: `tmux source ~/.config/tmux/tmux.conf`

---

## File Structure

```
~/.config/tmux/
├── tmux.conf           # Main configuration
├── tmux.reset.conf     # Reset defaults
└── plugins/            # TPM plugins (auto-managed)
    ├── tpm/
    ├── catppuccin-tmux/
    ├── tmux-sensible/
    ├── tmux-yank/
    ├── tmux-battery/
    ├── tmux-floax/
    ├── tmux-fzf/
    ├── tmux-fzf-links/
    └── tmux-thumbs/
```

---

## Tips

### Common Commands

```bash
# Start new session
tmux new -s mysession

# Attach to session
tmux attach -t mysession

# List sessions
tmux ls

# Kill session
tmux kill-session -t mysession
```

### Startup Script

The alias `t` runs a custom tmux startup script at `~/.config/scripts/TmuxStartup.sh`.

### Troubleshooting

```bash
# Reload configuration
tmux source ~/.config/tmux/tmux.conf

# Kill server (reset everything)
tmux kill-server

# Check for errors
tmux show-messages
```
