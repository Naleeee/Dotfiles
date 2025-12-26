# Hyprland Configuration

A modern Wayland tiling compositor with smooth animations, rounded corners, and a cohesive Catppuccin theme. Includes Hyprlock, Hypridle, and Hyprpaper for a complete desktop experience.

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
- [Related Tools](#related-tools)
- [Keyboard Input Configuration](#keyboard-input-configuration)
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

| Component | Purpose | Config File |
|-----------|---------|-------------|
| **Hyprland** | Window manager | `hyprland.conf` |
| **Hyprlock** | Lock screen | `hyprlock.conf` |
| **Hypridle** | Idle daemon | `hypridle.conf` |
| **Hyprpaper** | Wallpaper manager | `hyprpaper.conf` |
| **Waybar** | Status bar | See [Waybar.md](Waybar.md) |
| **Wofi** | App launcher | See [Wofi.md](Wofi.md) |
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

The configuration supports multiple monitor setups:

```conf
# Current setup: External monitor above laptop
monitor=eDP-1,preferred,0x1080,1      # Laptop display (below)
monitor=HDMI-A-1,preferred,0x0,1      # External monitor (above)
```

### Alternative Configurations

```conf
# Side by side
monitor=eDP-1,preferred,auto,1
monitor=HDMI-A-1,preferred,auto,auto

# Widescreen above
monitor=eDP-1,preferred,0x1440,1
monitor=HDMI-A-1,preferred,0x0,1
```

---

## Autostart Applications

On startup, the following are launched:

```conf
exec-once = waybar & swaync & hypridle & hyprpaper & swayosd-server
exec-once = [workspace 1 silent] kitty
exec-once = [workspace 2 silent] brave
exec-once = [workspace 3 silent] vesktop
```

| Application | Workspace | Purpose |
|-------------|-----------|---------|
| Waybar | - | Status bar |
| Swaync | - | Notification center |
| Hypridle | - | Idle management |
| Hyprpaper | - | Wallpaper |
| SwayOSD | - | On-screen display |
| Kitty | 1 | Terminal |
| Brave | 2 | Browser |
| Vesktop | 3 | Discord client |


---

## Hyprlock

Lock screen with Catppuccin theme, time display, and user avatar.

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

Wallpaper manager with per-monitor support.

### Configuration

```conf
preload = ~/.config/backgrounds/paladin-strait.png
preload = ~/.config/backgrounds/DessinTopFull.png

wallpaper = eDP-1, ~/.config/backgrounds/paladin-strait.png
wallpaper = HDMI-A-1, ~/.config/backgrounds/DessinTopFull.png
```

---

## Related Tools

- [Waybar](Waybar.md) - Status bar
- [Wofi](Wofi.md) - Application launcher
- [SwayOSD](https://github.com/ErikReider/SwayOSD) - On-screen display
- [Swaync](https://github.com/ErikReider/SwayNotificationCenter) - Notification center
- [Hyprshot](https://github.com/Gustash/Hyprshot) - Screenshot tool

---

## Keyboard Input Configuration

```conf
input {
    kb_layout = us,fr                    # US and French layouts
    kb_options = grp:win_space_toggle    # Win+Space to switch layout
    follow_mouse = 1
    sensitivity = 0
    
    touchpad {
        natural_scroll = true
    }
}
```

---

## Tips

### Debugging

```bash
# Check Hyprland logs
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log

# List monitors
hyprctl monitors

# List windows
hyprctl clients
```

### Useful Commands

```bash
# Reload config (automatic on save)
hyprctl reload

# Toggle window floating
hyprctl dispatch togglefloating

# Move to workspace
hyprctl dispatch workspace 1
```

