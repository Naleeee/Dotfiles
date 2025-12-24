# Yazi Configuration

A blazing fast terminal file manager with Catppuccin Mocha theme and intuitive keybindings.

---

## Table of Contents

- [Overview](#overview)
- [Theme](#theme)
- [Keybindings](#keybindings)
- [Features](#features)
- [Configuration](#configuration)
- [Installation](#installation)

---

## Overview

[Yazi](https://yazi-rs.github.io/) is a terminal file manager written in Rust, featuring:

- **Async I/O** for fast file operations
- **Image previews** in terminal
- **Vi-like keybindings**
- **Plugin system**
- **Catppuccin Mocha** theme

### Quick Access

Use the Zsh alias:

```bash
y    # Opens Yazi
```

---

## Theme

### Catppuccin Mocha

The theme is loaded from `~/.config/yazi/flavors/catppuccin-mocha.yazi/`:

| Element | Color |
|---------|-------|
| Selection | Mauve |
| Directories | Blue |
| Executables | Green |
| Symlinks | Cyan |
| Archive files | Red |

---

## Keybindings

### Navigation

| Key | Action |
|-----|--------|
| `h` / `←` | Parent directory |
| `l` / `→` / `Enter` | Open file/directory |
| `j` / `↓` | Move down |
| `k` / `↑` | Move up |
| `gg` | Go to top |
| `G` | Go to bottom |
| `~` | Go to home |

### Selection

| Key | Action |
|-----|--------|
| `Space` | Toggle selection |
| `v` | Visual mode |
| `V` | Visual line mode |
| `Ctrl+a` | Select all |
| `Ctrl+r` | Inverse selection |

### File Operations

| Key | Action |
|-----|--------|
| `a` | Create file/directory |
| `r` | Rename |
| `y` | Yank (copy) |
| `x` | Cut |
| `p` | Paste |
| `d` | Trash |
| `D` | Permanently delete |

### Search & Filter

| Key | Action |
|-----|--------|
| `/` | Search |
| `n` | Next match |
| `N` | Previous match |
| `f` | Filter |
| `z` | Jump (fzf) |

### View

| Key | Action |
|-----|--------|
| `.` | Toggle hidden files |
| `Tab` | Switch pane |
| `~` | Help |
| `q` | Quit |

---

## Features

### File Previews

Yazi supports previewing:

- **Images** (with ueberzug++ or Kitty protocol)
- **Text files** with syntax highlighting
- **PDFs**
- **Videos** (thumbnail)
- **Archives** (contents listing)
- **JSON** with formatting

### Opener Configuration

Files are opened with appropriate applications:

```toml
[opener]
edit = [
  { run = '${EDITOR:-vi} "$@"', desc = "$EDITOR", block = true }
]
open = [
  { run = 'xdg-open "$1"', desc = "Open", for = "linux" }
]
```

### Archive Support

Extract archives directly:

| Format | Support |
|--------|---------|
| ZIP | Yes |
| TAR | Yes |
| GZ/XZ | Yes |
| 7Z | Yes |
| RAR | Yes |

---

## Configuration

### Manager Settings

```toml
[mgr]
ratio = [1, 4, 3]           # Pane ratios
sort_by = "alphabetical"
sort_dir_first = true
show_hidden = false
show_symlink = true
scrolloff = 5               # Lines to keep visible
```

### Preview Settings

```toml
[preview]
tab_size = 2
max_width = 600
max_height = 900
image_filter = "triangle"
image_quality = 75
```

---

## File Structure

```
~/.config/yazi/
├── yazi.toml       # Main configuration
├── keymap.toml     # Keybindings
├── theme.toml      # Theme settings
├── package.toml    # Plugins
└── flavors/        # Color schemes
    └── catppuccin-mocha.yazi/
```

---

## Installation

```bash
# Arch/Manjaro
sudo pacman -S yazi

# macOS
brew install yazi

# Cargo
cargo install yazi-fm yazi-cli
```

### Image Preview Dependencies

```bash
# For image previews
sudo pacman -S ueberzugpp    # X11/Wayland
# Or use Kitty's built-in protocol
```

---

## Tips

### Shell Integration

Yazi can change the current directory on exit:

```bash
# Add to .zshrc
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
```

### Useful Commands

```bash
# Open with specific path
yazi /path/to/directory

# Show help
yazi --help
```

