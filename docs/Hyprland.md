# Hyprland Configuration

A modern Wayland tiling compositor with smooth animations, rounded corners, and a cohesive Catppuccin theme. Includes Hyprlock, Hypridle, Hyprpaper, Waybar, and Wofi for a complete desktop experience.

---

## Table of Contents

- [Overview](#overview)
- [Components](#components)
- [Keybindings](#keybindings)
- [Monitor Setup](#monitor-setup)
- [Autostart Applications](#autostart-applications)
- [Hyprlock](#hyprlock)
- [Hypridle](#hypridle)
- [Hyprpaper](#hyprpaper)
- [Waybar](#waybar)
- [Wofi](#wofi)
- [Keyboard Input](#keyboard-input)
- [Tips](#tips)

---

## Overview

[Hyprland](https://hyprland.org/) is a dynamic tiling Wayland compositor with excellent animations and modern features. This configuration provides:

- Tiled window management with dwindle layout
- Smooth animations and rounded corners
- Multi-monitor support
- Custom keybindings with Alt as modifier
- Integration with Waybar, Wofi, and other tools
- Automatic screen locking with Hyprlock/Hypridle

### Theme

Catppuccin Mocha colors are used throughout, matching the terminal and Neovim setup.

---

## Components

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Hyprland** | Window manager | `~/.config/hypr/hyprland.conf` |
| **Hyprlock** | Lock screen | `~/.config/hypr/hyprlock.conf` |
| **Hypridle** | Idle daemon | `~/.config/hypr/hypridle.conf` |
| **Hyprpaper** | Wallpaper manager | `~/.config/hypr/hyprpaper.conf` |
| **Waybar** | Status bar | `~/.config/waybar/` |
| **Wofi** | App launcher | `~/.config/wofi/` |
| **SwayOSD** | On-screen display | Volume/brightness indicators |

---

## Keybindings

**Main Modifier:** `Alt`

### Application Shortcuts

| Keybinding | Action |
|------------|--------|
| `Alt + Q` | Open terminal (Kitty) |
| `Alt + E` | Open file manager (Nautilus) |
| `Alt + Space` | Open app launcher (Wofi) |
| `Alt + C` | Close active window |
| `Alt + M` | Exit Hyprland |
| `Super + L` | Lock screen |

### Window Management

| Keybinding | Action |
|------------|--------|
| `Alt + H/J/K/L` | Move focus left/down/up/right |
| `Alt + V` | Toggle floating mode |
| `Alt + P` | Toggle pseudo-tiling |
| `Alt + F` | Maximize window |
| `Alt + Shift + F` | Fullscreen window |

### Workspaces

| Keybinding | Action |
|------------|--------|
| `Alt + 1-9, 0` | Switch to workspace 1-10 |
| `Alt + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Alt + S` | Toggle special workspace (scratchpad) |
| `Alt + Shift + S` | Move window to special workspace |

### Screenshots

| Keybinding | Action |
|------------|--------|
| `Print` | Screenshot window (clipboard) |
| `Super + Shift + S` | Screenshot region with grim/slurp |

---

## Monitor Setup

```conf
# Current setup: External monitor above laptop
monitor=eDP-1,preferred,0x1080,1      # Laptop display (below)
monitor=HDMI-A-1,preferred,0x0,1      # External monitor (above)
```

---

## Autostart Applications

```conf
exec-once = waybar & swaync & hypridle & hyprpaper & swayosd-server
exec-once = [workspace 1 silent] kitty
exec-once = [workspace 2 silent] brave
exec-once = [workspace 3 silent] vesktop
```

---

## Hyprlock

Lock screen with Catppuccin theme featuring:

- Blurred background wallpaper
- Time and date display
- User avatar
- Password input with visual feedback
- Caps lock indicator

---

## Hypridle

Automatic actions based on idle time:

| Timeout | Action |
|---------|--------|
| 2.5 min | Start screensaver |
| 5 min | Lock screen |
| 5.5 min | Turn off display |

---

## Hyprpaper

Wallpaper manager with per-monitor support:

```conf
preload = ~/.config/backgrounds/paladin-strait.png
wallpaper = eDP-1, ~/.config/backgrounds/paladin-strait.png
wallpaper = HDMI-A-1, ~/.config/backgrounds/DessinTopFull.png
```

---

## Waybar

[Waybar](https://github.com/Alexays/Waybar) status bar positioned at the top with Catppuccin Mocha theme.

### Layout

```
[Workspaces] ─── [Clock | Window Title] ─── [Network | Bluetooth | Audio | CPU | Battery]
```

### Modules

| Module | Icon | Click Action |
|--------|------|--------------|
| Workspaces | 1-5 | Switch workspace |
| Clock | - | Calendar tooltip |
| Network | 󰤨 | Open network manager |
| Bluetooth |  | Open Blueberry |
| Audio |  | Open mixer / Toggle mute |
| CPU | 󰍛 | Open btop |
| Battery | 󰁹 | - |

### Files

- `~/.config/waybar/config.jsonc` - Module configuration
- `~/.config/waybar/style.css` - Visual styling

---

## Wofi

[Wofi](https://hg.sr.ht/~scoopta/wofi) application launcher with Catppuccin Mocha theme.

### Usage

| Key | Action |
|-----|--------|
| `Alt + Space` | Open launcher |
| Type | Filter applications |
| `Enter` | Launch selected |
| `Escape` | Close |

### Files

- `~/.config/wofi/style.css` - Visual styling

---

## Keyboard Input

```conf
input {
    kb_layout = us,fr                    # US and French layouts
    kb_options = grp:win_space_toggle    # Win+Space to switch layout
    follow_mouse = 1
    
    touchpad {
        natural_scroll = true
    }
}
```

---

## Tips

### Useful Commands

```bash
# Reload config (automatic on save)
hyprctl reload

# List monitors
hyprctl monitors

# List windows
hyprctl clients

# Restart Waybar
killall waybar && waybar &
```

### Related Tools

- [SwayOSD](https://github.com/ErikReider/SwayOSD) - On-screen display
- [Swaync](https://github.com/ErikReider/SwayNotificationCenter) - Notification center
- [Hyprshot](https://github.com/Gustash/Hyprshot) - Screenshot tool
