# Zsh Configuration

A powerful Zsh setup with Oh My Zsh, Powerlevel10k theme, and productivity-focused aliases for development workflows.

---

## Table of Contents

- [Overview](#overview)
- [Theme](#theme)
- [Plugins](#plugins)
- [Aliases](#aliases)
  - [Navigation](#navigation)
  - [Neovim](#neovim)
  - [Git](#git)
  - [Docker](#docker)
  - [Development](#development)
- [Environment Setup](#environment-setup)
- [Custom Functions](#custom-functions)
- [Installation](#installation)

---

## Overview

This configuration uses:

- **[Zsh](https://www.zsh.org/)** - Feature-rich shell
- **[Oh My Zsh](https://ohmyz.sh/)** - Framework for managing Zsh configuration
- **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)** - Fast and customizable prompt theme
- **[Zoxide](https://github.com/ajeetdsouza/zoxide)** - Smarter cd command

---

## Theme

### Powerlevel10k

A highly customizable prompt theme with:

- Git status indicators
- Command execution time
- Directory path with truncation
- Status indicators for background jobs
- Fast rendering with instant prompt

Configure by running:

```bash
p10k configure
```

Or edit `~/.p10k.zsh` directly.

---

## Plugins

Active plugins in `.zshrc`:

| Plugin | Description |
|--------|-------------|
| [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git) | Git aliases and functions |
| [dirhistory](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory) | Navigate directory history with Alt+arrows |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like autosuggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Command syntax highlighting |
| [zsh-bat](https://github.com/fdellwing/zsh-bat) | Bat integration |

### Plugin Features

**dirhistory** keybindings:
- `Alt + Left` - Previous directory
- `Alt + Right` - Next directory
- `Alt + Up` - Parent directory

**zsh-autosuggestions**:
- Suggests commands as you type based on history
- Press `Right Arrow` or `End` to accept

---

## Aliases

### Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `cd` | `z` | Zoxide smart directory jump |
| `ls` | `eza --color=always --icons` | Better ls with icons |
| `l` | `clear && ls -l` | Clear screen and list |
| `y` | `yazi` | Yazi file manager |

### Neovim

| Alias | Command | Description |
|-------|---------|-------------|
| `v` | `nvim` | Open Neovim |

### Git

| Alias | Command | Description |
|-------|---------|-------------|
| `gs` | `git switch` | Switch branch |
| `gb` | `git branch` | List branches |
| `gm` | `git merge` | Merge branch |
| `gl` | `git pull` | Pull from remote |
| `gps` | `git push --set-upstream origin` | Push with upstream |
| `fdp` | `git blame` | Show file blame |
| `fsb` | Script | Fuzzy search branches |
| `fsc` | Script | Fuzzy search commits |
| `glog` | SSH agent | Re-authenticate git |

### Docker

| Alias | Command | Description |
|-------|---------|-------------|
| `dps` | `docker ps -s` | List running containers |
| `dpsa` | `docker ps -a -s` | List all containers |
| `dkr` | `docker kill $(docker ps -q)` | Kill all running containers |
| `dks` | `docker rm $(docker ps -a -q)` | Remove stopped containers |
| `drmi` | `docker rmi $(docker images -q)` | Remove all images |
| `de` | `docker exec -it /bin/bash` | Exec into container |
| `des` | `docker exec -it -u root /bin/bash` | Exec as root |
| `dh` | Help text | Show Docker aliases help |

### Search

| Alias | Command | Description |
|-------|---------|-------------|
| `trouve` | `grep -rn --exclude-dir=...` | Recursive grep excluding common dirs |

---

## Environment Setup

### SSH Agent

Auto-starts SSH agent and adds key on shell start:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/NaleComptastarKey
```

---

## Custom Functions

### gnb - Git New Branch

Creates a new branch, switches to it, and sets up remote tracking:

```bash
gnb() {
    git branch "$1"
    git switch "$1"
    git push --set-upstream origin "$1"
}
```

Usage:
```bash
gnb feature/new-feature
```

---

## Installation

### Prerequisites

```bash
# Install Zsh
sudo pacman -S zsh  # Arch

# Set as default shell
chsh -s $(which zsh)
```

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Plugins

```bash
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Additional Tools

```bash
# Zoxide (better cd)
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Eza (better ls)
sudo pacman -S eza  # Arch

# Fzf (fuzzy finder)
sudo pacman -S fzf
```

---

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.zshrc` | Main Zsh configuration |
| `~/.p10k.zsh` | Powerlevel10k theme settings |

---

## Tips

### Useful Commands

```bash
# Reload configuration
source ~/.zshrc

# Reconfigure Powerlevel10k
p10k configure

# View command history
history

# Search history
Ctrl+R
```

