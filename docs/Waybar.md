# Waybar Configuration

A customized Wayland status bar with Catppuccin Mocha theme, displaying system information and workspace indicators.

---

## Table of Contents

- [Overview](#overview)
- [Modules](#modules)
- [Theme](#theme)
- [Customization](#customization)
- [Installation](#installation)

---

## Overview

[Waybar](https://github.com/Alexays/Waybar) is a highly customizable status bar for Wayland compositors. This configuration provides:

- **Workspace indicators** with numbered icons
- **System monitors** (CPU, network, battery)
- **Audio control** with click actions
- **Catppuccin Mocha** color scheme
- **Minimal, modern design**

### Position

Status bar positioned at the **top** of the screen with 26px height.

---

## Modules

### Layout

```
[Workspaces] ─────── [Clock | Window Title] ─────── [Network | Bluetooth | Audio | CPU | Battery]
```

### Left: Workspaces

Displays workspaces 1-5 with numbered indicators:

| State | Appearance |
|-------|------------|
| Active | Mauve with top border |
| Inactive | Mauve text |
| Urgent | Red background |

Click on workspace number to switch.

### Center: Clock & Window

| Module | Format | Example |
|--------|--------|---------|
| Clock | `%a %d/%m %H:%M` | `Tue 24/12 14:30` |
| Window | Active window title | `Neovim - file.ts` |

Hover over clock for calendar tooltip.

### Right: System Info

| Module | Icon | Click Action |
|--------|------|--------------|
| Network | 󰤨 (signal strength) | Open Impala (network manager) |
| Bluetooth |  | Open Blueberry |
| Audio |  | Open Wiremix / Toggle mute |
| CPU | 󰍛 | Open btop |
| Battery | 󰁹 (level indicator) | - |

---

## Theme

### Colors (Catppuccin Mocha)

```css
@import "../mocha.css";

window#waybar {
  background-color: @crust;
  color: @overlay0;
  border-bottom: 1px solid @overlay1;
}
```

### Module Colors

| Module | Color | CSS Variable |
|--------|-------|--------------|
| Clock | Maroon | `@maroon` |
| Window | Maroon | `@maroon` |
| Network | Yellow | `@yellow` |
| Bluetooth | Blue | `@blue` |
| Audio | Teal | `@teal` |
| CPU | Maroon | `@maroon` |
| Battery | Green | `@green` |
| Workspaces | Mauve | `@mauve` |

### Font

**MesloLGS Nerd Font Mono Bold** at 14px

---

## Module Details

### Workspaces

```jsonc
"hyprland/workspaces": {
  "format": "{icon}",
  "format-icons": {
    "default": "",
    "1": "1", "2": "2", "3": "3", "4": "4", "5": "5",
    "active": "󱓻"
  },
  "persistent-workspaces": {
    "1": [], "2": [], "3": [], "4": [], "5": []
  }
}
```

### Network

```jsonc
"network": {
  "format-icons": ["󰤯","󰤟","󰤢","󰤥","󰤨"],
  "format-wifi": "{icon}",
  "format-ethernet": "󰀂",
  "format-disconnected": "󰖪",
  "tooltip-format-wifi": "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}"
}
```

### Battery

```jsonc
"battery": {
  "format": "{icon}  {capacity}%",
  "format-plugged": "",
  "format-full": "󰂅",
  "format-icons": {
    "charging": ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
    "default": ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
  },
  "states": {
    "warning": 20,
    "critical": 10
  }
}
```

---

## Customization

### Adding Modules

Edit `~/.config/waybar/config.jsonc`:

```jsonc
{
  "modules-left": ["hyprland/workspaces", "custom/new-module"],
  "modules-right": ["network", "battery"],
  
  "custom/new-module": {
    "format": "{}",
    "exec": "script.sh",
    "interval": 5
  }
}
```

### Styling

Edit `~/.config/waybar/style.css`:

```css
#custom-new-module {
  color: @blue;
  padding: 0 10px;
}
```

### Live Reload

Waybar auto-reloads on config change:

```jsonc
"reload_style_on_change": true
```

---

## File Structure

```
~/.config/waybar/
├── config.jsonc    # Module configuration
└── style.css       # Visual styling
```

---

## Installation

```bash
# Arch/Manjaro
sudo pacman -S waybar

# Start with Hyprland (in hyprland.conf)
exec-once = waybar
```

---

## Troubleshooting

### Restart Waybar

```bash
killall waybar && waybar &
```

### Debug Mode

```bash
waybar -l debug
```

### Check Configuration

```bash
# Validate JSON
cat ~/.config/waybar/config.jsonc | jq
```
