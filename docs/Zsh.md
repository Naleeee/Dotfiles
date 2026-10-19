# Zsh Configuration

A powerful Zsh setup with Oh My Zsh, Starship prompt, and
productivity-focused aliases for development workflows.

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
- **[Starship](https://starship.rs/)** - Fast, cross-shell prompt
- **[Zoxide](https://github.com/ajeetdsouza/zoxide)** - Smarter cd command

---

## Theme

### Starship

A cross-shell prompt written in Rust, configured in `~/.config/starship.toml`:

- Two-line powerline prompt in Catppuccin Mocha
- OS icon, directory, git branch and git status on the first line
- On the right: exit code on failure, command duration over 3s, background
  jobs, Node and Python versions, and the time

Modules only render when relevant, so the prompt stays short outside projects.

---

## Plugins

Active plugins in `.zshrc`:

| Plugin                                                                          | Description                                |
| ------------------------------------------------------------------------------- | ------------------------------------------ |
| [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)               | Git aliases and functions                  |
| [dirhistory](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory) | Navigate directory history with Alt+arrows |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)         | Fish-like autosuggestions                  |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Command syntax highlighting                |
| [zsh-bat](https://github.com/fdellwing/zsh-bat)                                 | Bat integration                            |

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

| Alias | Command                      | Description                 |
| ----- | ---------------------------- | --------------------------- |
| `cd`  | `z`                          | Zoxide smart directory jump |
| `ls`  | `eza --color=always --icons` | Better ls with icons        |
| `l`   | `clear && ls -l`             | Clear screen and list       |
| `y`   | `yazi`                       | Yazi file manager           |

### Neovim

| Alias | Command | Description |
| ----- | ------- | ----------- |
| `v`   | `nvim`  | Open Neovim |

### Git

| Alias  | Command                          | Description           |
| ------ | -------------------------------- | --------------------- |
| `gs`   | `git switch`                     | Switch branch         |
| `gb`   | `git branch`                     | List branches         |
| `gm`   | `git merge`                      | Merge branch          |
| `gl`   | `git pull`                       | Pull from remote      |
| `gps`  | `git push --set-upstream origin` | Push with upstream    |
| `fdp`  | `git blame`                      | Show file blame       |
| `fsb`  | Script                           | Fuzzy search branches |
| `fsc`  | Script                           | Fuzzy search commits  |
| `glog` | SSH agent                        | Re-authenticate git   |

### Docker

| Alias  | Command                             | Description                 |
| ------ | ----------------------------------- | --------------------------- |
| `dps`  | `docker ps -s`                      | List running containers     |
| `dpsa` | `docker ps -a -s`                   | List all containers         |
| `dkr`  | `docker kill $(docker ps -q)`       | Kill all running containers |
| `dks`  | `docker rm $(docker ps -a -q)`      | Remove stopped containers   |
| `drmi` | `docker rmi $(docker images -q)`    | Remove all images           |
| `de`   | `docker exec -it /bin/bash`         | Exec into container         |
| `des`  | `docker exec -it -u root /bin/bash` | Exec as root                |
| `dh`   | Help text                           | Show Docker aliases help    |

### Search

| Alias    | Command                      | Description                          |
| -------- | ---------------------------- | ------------------------------------ |
| `trouve` | `grep -rn --exclude-dir=...` | Recursive grep excluding common dirs |

---

## Environment Setup

### SSH Agent

Auto-starts SSH agent and adds key on shell start:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/NaleShellKey
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

### Starship

```bash
brew install starship    # macOS
sudo pacman -S starship  # Arch
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

| File                      | Purpose                |
| ------------------------- | ---------------------- |
| `~/.zshrc`                | Main Zsh configuration |
| `~/.config/starship.toml` | Starship prompt config |

---

## Tips

### Useful Commands

```bash
# Reload configuration
source ~/.zshrc

# Explain the modules shown in the current prompt
starship explain

# View command history
history

# Search history
Ctrl+R
```
