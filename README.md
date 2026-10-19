<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
  <a href="https://github.com/Naleeee/Dotfiles">
    <img src="docs/assets/Logo.jpg" alt="Logo" width="300" height="231">
  </a>

<h1>Nale's Dotfiles</h1>

  <p>
    A complete development environment configuration featuring <strong>Neovim</strong>, <strong>Hyprland</strong>, <strong>Zsh</strong>, <strong>Tmux</strong>, and more.
    <br />
    Unified with the <strong>Catppuccin Mocha</strong> color scheme for a cohesive aesthetic.
  </p>

  <p>
    <a href="https://github.com/Naleeee/Dotfiles"><strong>Explore the project »</strong></a>
  </p>
</div>

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Using GNU Stow](#using-gnu-stow)
  - [Manual Installation](#manual-installation)
- [Worktree Workflow](#worktree-workflow)
  - [How It Works](#how-it-works)
  - [Daily Workflow](#daily-workflow)
- [Documentation](#documentation)
- [Version Requirements](#version-requirements)
- [Roadmap](#roadmap)
- [Contact](#contact)

---

## Overview

This repository contains my personal dotfiles for a complete Linux development environment. Every component is configured with the **Catppuccin Mocha** theme for visual consistency across the entire workflow.

### Key Features

- **Modern Neovim Setup** - Fully Lua-based configuration with LSP, autocompletion, and 40+ plugins managed by Lazy.nvim
- **Hyprland Window Manager** - Tiling Wayland compositor with animations and custom keybindings
- **Enhanced Terminal** - Kitty terminal with Zsh, Oh My Zsh, and Starship
- **Tmux Integration** - Session management with custom theme and plugins
- **Additional Tools** - Waybar, Wofi, Yazi file manager, and more

---

## Features

| Component | Description | Documentation |
|-----------|-------------|---------------|
| **Neovim** | Text editor with LSP, completion, and modern plugins | [docs/Neovim.md](docs/Neovim.md) |
| **Hyprland** | Wayland tiling compositor | [docs/Hyprland.md](docs/Hyprland.md) |
| **Zsh** | Shell with Oh My Zsh and Starship | [docs/Zsh.md](docs/Zsh.md) |
| **Tmux** | Terminal multiplexer | [docs/Tmux.md](docs/Tmux.md) |
| **Worktrees** | Ticket and review workflow with Worktrunk and sesh | [docs/Worktrees.md](docs/Worktrees.md) |
| **Kitty** | GPU-accelerated terminal | [docs/Kitty.md](docs/Kitty.md) |
| **Waybar** | Status bar for Wayland | [docs/Waybar.md](docs/Waybar.md) |
| **Wofi** | Application launcher | [docs/Wofi.md](docs/Wofi.md) |
| **Yazi** | Terminal file manager | [docs/Yazi.md](docs/Yazi.md) |

---

## Installation

### Prerequisites

Before installing, ensure you have the following tools available:

```bash
# Required
git
stow        # GNU Stow for symlink management

# For Neovim
neovim >= 0.11
ripgrep     # For Telescope live grep
fzf         # Fuzzy finder
node        # For LSP servers and plugins
npm/pnpm    # Package manager

# For Hyprland
hyprland
waybar
wofi
hyprlock
hypridle
hyprpaper

# For Terminal
kitty
zsh
tmux
```

### Using GNU Stow

[GNU Stow](https://www.gnu.org/software/stow/) is used to manage symlinks from this repository to your home directory. This keeps your dotfiles organized and version-controlled.

#### Quick Start

```bash
# 1. Clone the repository to your home directory
cd ~
git clone https://github.com/Naleeee/Dotfiles.git
cd Dotfiles

# 2. Install GNU Stow on
# Arch/Manjaro
sudo pacman -S stow

# macOS
brew install stow

# 3. Stow all configurations (creates symlinks)
stow .

# Or stow specific components
stow .config/nvim      # Neovim only
stow .config/kitty     # Kitty only
stow .config/tmux      # Tmux only
```

#### How Stow Works

When you run `stow .` from the Dotfiles directory, it creates symlinks in your home directory that point to the files in this repository:

```
~/Dotfiles/.config/nvim  →  ~/.config/nvim
~/Dotfiles/.config/kitty →  ~/.config/kitty
~/Dotfiles/.zshrc        →  ~/.zshrc
...
```

#### Managing Stow

```bash
# Add new symlinks (stow)
stow .

# Remove symlinks (unstow)
stow -D .

# Re-stow (unstow then stow - useful after adding new files)
stow -R .

# Simulate what would happen (dry run)
stow -n -v .

# Ignore specific patterns
stow --ignore='README.*' --ignore='*.md' .
```

#### Handling Conflicts

If you have existing config files, stow will refuse to overwrite them. To resolve:

```bash
# Option 1: Backup and remove existing configs
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.zshrc ~/.zshrc.backup

# Option 2: Adopt existing files into the repository
stow --adopt .
# Warning: This moves your existing files INTO the Dotfiles repo
```


### Post-Installation

After stowing the configurations:

```bash
# 1. Install Neovim plugins (automatic on first launch)
nvim
# Lazy.nvim will auto-install plugins

# 2. Install Tmux plugins
tmux
# Press prefix + I (Ctrl-A + I) to install plugins

# 3. Configure Zsh
# Oh My Zsh will prompt for configuration
zsh

# 4. Install required fonts
# The config uses Caskaydia Cove Nerd Font
# Download from: https://www.nerdfonts.com/
```

---

## Worktree Workflow

Project work runs on git worktrees instead of branch switching: one tmux session per project, one worktree and one tmux window per ticket or PR review. Full reference in [docs/Worktrees.md](docs/Worktrees.md).

### How It Works

- [sesh](https://github.com/joshmedeski/sesh) creates tmux sessions from `.config/sesh/sesh.toml`. The `App` session opens with a Develop shell on the primary checkout, which stays on `develop`, a Servers window (`turbo dev` and ngrok) and a Database window (lazysql). The `Dotfiles` session opens Neovim on this repo.
- [Worktrunk](https://worktrunk.dev/) creates worktrees next to the repo, named `<repo>.<branch>`. Hooks in `.config/worktrunk/config.toml` copy the gitignored env files and `node_modules`, run `bun install`, and on removal drop the ticket database and close its tmux window.
- Three scripts in `.config/scripts/` glue them together: `wtn` opens a ticket worktree in a new window, `wtdb` gives it its own database, and the gh-dash `D` key opens a PR worktree for review.
- The servers run once, in the Servers window. `wt srv` points them at whichever worktree you run it from.
- [Workmux](https://github.com/raine/workmux) is only used for its agent dashboard (`Prefix + Ctrl + s`), fed by Claude Code hooks in `.claude/settings.json`. Worktrees stay with Worktrunk.

### Daily Workflow

1. **Open the workspace**: `t` connects to the App session, creating it on first run. `Prefix + T` switches to any other session.
2. **Start a ticket**: from the Develop window, `wtn feature/abc-123-foo`. Worktrunk branches from `develop`, creates the worktree, copies the env files and `node_modules`, runs `bun install`, and an `ABC-123` window opens with Neovim. The same command reopens an existing branch.
3. **Run it**: `wt srv` from the ticket window restarts `turbo dev` in that worktree. ngrok keeps forwarding to the API port.
4. **Migrations**: if the ticket changes the Prisma schema, `wtdb` clones the main database as `<db>_abc_123`, rewrites `DATABASE_URL` in the worktree and adds a lazysql connection. Other tickets share the main database.
5. **Review a PR**: `Prefix + T` to Dash, then `D` on the pull request. A `PR-N` window opens with tuicr and Claude in a PR worktree. `wt remove` in that window cleans it up (`-D` also deletes an unmerged local branch).
6. **Finish**: `wt srv` from the Develop window points the servers back at the primary checkout, then `wt remove feature/abc-123-foo` drops the database, deletes the worktree and branch, and closes the window.

---

## Documentation

Detailed documentation for each component:

| Document | Description |
|----------|-------------|
| [Neovim](docs/Neovim.md) | Complete editor setup, plugins, keybindings, LSP configuration |
| [Hyprland](docs/Hyprland.md) | Window manager config, keybindings, autostart, Hyprlock/Hyprpaper |
| [Zsh](docs/Zsh.md) | Shell configuration, aliases, plugins, Starship prompt |
| [Tmux](docs/Tmux.md) | Session management, plugins, keybindings, Catppuccin theme |
| [Worktrees](docs/Worktrees.md) | Worktrunk hooks, sesh sessions, ticket and review scripts |
| [Kitty](docs/Kitty.md) | Terminal configuration, fonts, keybindings |
| [Waybar](docs/Waybar.md) | Status bar modules and styling |
| [Wofi](docs/Wofi.md) | Application launcher configuration |
| [Yazi](docs/Yazi.md) | File manager configuration |

---

## Version Requirements

| Tool | Minimum Version |
|------|-----------------|
| Neovim | 0.11+ |
| Zsh | 5.9+ |
| Kitty | 0.31.0+ |
| Tmux | 3.4+ |
| Hyprland | 0.45.2+ |

---

## Repository Structure

```
~/Dotfiles/
├── .config/
│   ├── backgrounds/       # Wallpapers
│   ├── btop/              # System monitor config
│   ├── eza/               # Better ls config
│   ├── hypr/              # Hyprland, Hyprlock, Hypridle, Hyprpaper
│   ├── kitty/             # Terminal emulator
│   ├── nvim/              # Neovim configuration
│   ├── scripts/           # Utility scripts
│   ├── swayosd/           # OSD for volume/brightness
│   ├── tmux/              # Tmux configuration
│   ├── waybar/            # Status bar
│   ├── wofi/              # App launcher
│   └── yazi/              # File manager
├── docs/                  # Documentation
├── .zshrc                 # Zsh configuration
└── README.md              # This file
```

---

## Roadmap

- [x] Full Lua Neovim configuration
- [x] Hyprland Wayland setup
- [x] Comprehensive documentation
- [x] GNU Stow installation method
- [ ] Automated installation script improvements (binaries, ssh-key...)

---

## Contact

**Nathan Lemale**

- Email: nthn.lemale@gmail.com
- Website: [nathanlemale.com](https://www.nathanlemale.com/)
- LinkedIn: [nathan-lemale](https://linkedin.com/in/nathan-lemale)
- GitHub: [Naleeee](https://github.com/Naleeee)

Project Link: [github.com/Naleeee/Dotfiles](https://github.com/Naleeee/Dotfiles)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/Naleeee/Dotfiles.svg?style=for-the-badge
[contributors-url]: https://github.com/Naleeee/Dotfiles/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Naleeee/Dotfiles.svg?style=for-the-badge
[forks-url]: https://github.com/Naleeee/Dotfiles/network/members
[stars-shield]: https://img.shields.io/github/stars/Naleeee/Dotfiles.svg?style=for-the-badge
[stars-url]: https://github.com/Naleeee/Dotfiles/stargazers
[issues-shield]: https://img.shields.io/github/issues/Naleeee/Dotfiles.svg?style=for-the-badge
[issues-url]: https://github.com/Naleeee/Dotfiles/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/nathan-lemale
