# Kitty Terminal Configuration

A GPU-accelerated terminal emulator with Catppuccin Mocha theme and optimized settings for development.

---

## Table of Contents

- [Overview](#overview)
- [Theme](#theme)
- [Font Configuration](#font-configuration)
- [Keybindings](#keybindings)
- [Settings](#settings)
- [Installation](#installation)

---

## Overview

[Kitty](https://sw.kovidgoyal.net/kitty/) is a fast, feature-rich, GPU-based terminal emulator. Key features of this configuration:

- **Catppuccin Mocha** color scheme
- **Caskaydia Cove Nerd Font** with ligatures
- **Minimal window decorations**
- **Custom keybindings** for window management
- **True color support** for Neovim and other tools

---

## Theme

### Catppuccin Mocha

The terminal uses Catppuccin Mocha colors matching the rest of the environment:

```conf
foreground            #cdd6f4
background            #1e1e2e
selection_foreground  #89b4fa
selection_background  #313244
url_color             #f38ba8
```

The theme is loaded from `current-theme.conf` which contains the full Catppuccin palette.

---

## Font Configuration

### Primary Font

**Caskaydia Cove Nerd Font** - A Nerd Font variant of Cascadia Code with:

- Programming ligatures
- Nerd Font icons
- Clear, modern design

```conf
font_family Caskaydia Cove Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 14
```

### Installing Nerd Fonts

```bash
# Arch Linux
sudo pacman -S ttf-cascadia-code-nerd

# macOS
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font

# Manual download
# https://www.nerdfonts.com/font-downloads
```

---

## Keybindings

### Copy/Paste

| Keybinding | Action |
|------------|--------|
| `Ctrl+C` | Copy or interrupt |
| `Ctrl+Shift+V` | Paste from clipboard (keep v-block NeoVim mode) |

### Window Management

| Keybinding | Action |
|------------|--------|
| `Ctrl+W` | Close window |
| `Ctrl+E` | New window (same directory) |
| `Ctrl+F` | Focus visible window |

---

## Settings

### Window Appearance

```conf
hide_window_decorations no    # Show window decorations
window_border_width 0         # No border
draw_minimal_borders yes      # Minimal borders
background_opacity 1          # Opaque background
```

---

## File Structure

```
~/.config/kitty/
├── kitty.conf           # Main configuration
└── current-theme.conf   # Color scheme (Catppuccin)
```

---

## Installation

### Install Kitty

```bash
# Arch/Manjaro
sudo pacman -S kitty

# macOS
brew install --cask kitty
```

### Apply Configuration

After stowing the dotfiles:

```bash
# Kitty auto-reloads on config change
# Or restart Kitty
```

---

## Integration

### With Hyprland

Kitty is set as the default terminal in Hyprland:

```conf
$terminal = kitty
```

### With Tmux

True color support is enabled for Tmux integration:

```conf
# In tmux.conf
set-option -sa terminal-overrides ",xterm-kitty:RGB"
```

### With Neovim

Full true color and Unicode support for Neovim features.

---

## Tips

### Useful Commands

```bash
# List available themes
kitty +kitten themes

# Show current configuration
kitty --debug-config

# Open config in editor
kitty +edit-config
```

