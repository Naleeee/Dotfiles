# Wofi Configuration

A Wayland-native application launcher styled with Catppuccin Mocha theme.

---

## Table of Contents

- [Overview](#overview)
- [Theme](#theme)
- [Usage](#usage)
- [Customization](#customization)
- [Installation](#installation)

---

## Overview

[Wofi](https://hg.sr.ht/~scoopta/wofi) is a launcher/menu program for Wayland, similar to rofi. This configuration provides:

- **Catppuccin Mocha** color scheme
- **Clean, minimal design**
- **Application search and launch**
- **Rounded corners** with border accent

---

## Theme

### Colors

Full Catppuccin Mocha palette defined in `style.css`:

| Element | Color | Variable |
|---------|-------|----------|
| Background | `#1e1e2e` | `@base` |
| Text | `#cdd6f4` | `@text` |
| Border | `#b4befe` | `@lavender` |
| Selected | `#cba6f7` | `@mauve` |
| Input accent | `#f38ba8` | `@red` |

### Styling

```css
window {
  border: 2px solid @lavender;
  border-radius: 8px;
  background-color: @base;
}

#entry:selected {
  border: 0.11em solid @lavender;
}

#entry:selected #text {
  color: @mauve;
}
```

### Font

**CaskaydiaCove Nerd Font** at 18px

---

## Usage

### Launch

In Hyprland, press `Alt + Space` to open Wofi:

```conf
bind = $mainMod, space, exec, wofi --show drun
```

### Modes

| Mode | Command | Description |
|------|---------|-------------|
| drun | `wofi --show drun` | Application launcher |
| run | `wofi --show run` | Command runner |
| dmenu | `wofi --show dmenu` | Dmenu mode |

### Navigation

| Key | Action |
|-----|--------|
| Type | Filter applications |
| `Up/Down` | Navigate results |
| `Enter` | Launch selected |
| `Escape` | Close |

---

## Customization

### Window Size

Edit the CSS to change dimensions:

```css
window {
  margin: 0px;
  padding: 10px;
}

#inner-box, #outer-box {
  margin: 5px;
  padding: 10px;
}
```

### Colors

Modify the color variables at the top of `style.css`:

```css
@define-color mauve #cba6f7;
@define-color red #f38ba8;
/* ... */
```

---

## File Structure

```
~/.config/wofi/
└── style.css    # Visual styling
```

---

## Installation

```bash
# Arch/Manjaro
sudo pacman -S wofi
```

---

## Tips

### Preview Theme Changes

```bash
# Test run
wofi --show drun

# With custom config
wofi --show drun --style ~/.config/wofi/style.css
```

### Alternative Launchers

- [rofi-wayland](https://github.com/lbonn/rofi) - Rofi fork for Wayland
- [fuzzel](https://codeberg.org/dnkl/fuzzel) - Lightweight launcher
