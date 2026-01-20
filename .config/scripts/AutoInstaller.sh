#!/bin/bash

#==============================================================================
#  Nale's Dotfiles - Auto Installer
#  A comprehensive setup script for the complete development environment
#  Supports: Arch Linux, macOS
#==============================================================================

set -e

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                              COLORS                                        ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# Using $'...' ANSI-C quoting for portable escape sequences
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
MAGENTA=$'\e[0;35m'
CYAN=$'\e[0;36m'
WHITE=$'\e[0;97m'
GRAY=$'\e[0;90m'
BOLD=$'\e[1m'
DIM=$'\e[2m'
ITALIC=$'\e[3m'
NC=$'\e[0m'

# Semantic colors
SUCCESS="${GREEN}✓${NC}"
FAIL="${RED}✗${NC}"
INFO="${CYAN}→${NC}"
WARN="${YELLOW}⚠${NC}"
SECTION="${MAGENTA}${BOLD}"
TOOL="${CYAN}${BOLD}"
DEP="${DIM}"

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                              HELPERS                                       ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

print_header() {
    printf "\n%s╔════════════════════════════════════════════════════════════════╗%s\n" "$MAGENTA" "$NC"
    printf "%s║%s  %s%s%s\n" "$MAGENTA" "$NC" "$BOLD" "$1" "$NC"
    printf "%s╚════════════════════════════════════════════════════════════════╝%s\n\n" "$MAGENTA" "$NC"
}

print_section() {
    printf "\n%s▶ %s%s\n\n" "$SECTION" "$1" "$NC"
}

print_tool() {
    printf "%s  %s%s\n" "$TOOL" "$1" "$NC"
}

print_dep() {
    printf "%s    └─ %s%s\n" "$DEP" "$1" "$NC"
}

print_info() {
    printf "%s %s\n" "$INFO" "$1"
}

print_success() {
    printf "%s %s\n" "$SUCCESS" "$1"
}

print_warn() {
    printf "%s %s%s%s\n" "$WARN" "$YELLOW" "$1" "$NC"
}

print_error() {
    printf "%s %s%s%s\n" "$FAIL" "$RED" "$1" "$NC"
}

prompt_yes_no() {
    local prompt="$1"
    local response
    while true; do
        printf "%s%s%s %s[Y/n]%s " "$CYAN" "$prompt" "$NC" "$DIM" "$NC"
        read -r response
        case "$response" in
            [Yy]|"") return 0 ;;
            [Nn]) return 1 ;;
            *) print_error "Please answer y or n" ;;
        esac
    done
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                         DISTRO DETECTION                                   ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

DISTRO=""
PKG_MANAGER=""

detect_distro() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        DISTRO="macos"
        PKG_MANAGER="brew"
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
        PKG_MANAGER="pacman"
    else
        DISTRO="unknown"
    fi
}

select_distro() {
    clear
    printf "%s%s" "$MAGENTA" "$BOLD"
    cat << "EOF"
    _   __      __     _        ____        __  _____ __         
   / | / /___ _/ /__  ( )___   / __ \____  / /_/ __(_) /__  _____
  /  |/ / __ `/ / _ \|// __ \ / / / / __ \/ __/ /_/ / / _ \/ ___/
 / /|  / /_/ / /  __/ / /_/ // /_/ / /_/ / /_/ __/ / /  __(__  ) 
/_/ |_/\__,_/_/\___/  \____(_)____/\____/\__/_/ /_/_/\___/____/  
                                                                 
EOF
    printf "%s\n" "$NC"
    printf "%sDevelopment Environment Setup%s\n" "$DIM" "$NC"
    printf "%s─────────────────────────────────────────%s\n\n" "$DIM" "$NC"

    # Auto-detect
    detect_distro
    
    printf "%sSelect your system:%s\n\n" "$BOLD" "$NC"
    printf "  %s1)%s Arch Linux      %s(pacman + yay)%s\n" "$CYAN" "$NC" "$DIM" "$NC"
    printf "  %s2)%s macOS           %s(Homebrew)%s\n" "$CYAN" "$NC" "$DIM" "$NC"
    printf "\n"
    
    if [ "$DISTRO" != "unknown" ]; then
        local detected_name=""
        case "$DISTRO" in
            arch) detected_name="Arch Linux" ;;
            macos) detected_name="macOS" ;;
        esac
        printf "%sDetected: %s%s\n\n" "$DIM" "$detected_name" "$NC"
    fi
    
    local choice
    printf "%sEnter choice [1-2]: %s" "$CYAN" "$NC"
    read -r choice
    
    case "$choice" in
        1) DISTRO="arch"; PKG_MANAGER="pacman" ;;
        2) DISTRO="macos"; PKG_MANAGER="brew" ;;
        *)
            print_error "Invalid choice"
            exit 1
            ;;
    esac
    
    echo ""
    print_success "Selected: $DISTRO ($PKG_MANAGER)"
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                     PACKAGE MANAGER FUNCTIONS                              ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# Check if package is installed
is_installed() {
    local pkg="$1"
    case "$PKG_MANAGER" in
        pacman) pacman -Qi "$pkg" &>/dev/null ;;
        brew) brew list "$pkg" &>/dev/null ;;
    esac
}

# Install a package
install_pkg() {
    local pkg="$1"
    
    if is_installed "$pkg"; then
        printf "    %s%s already installed%s\n" "$DIM" "$pkg" "$NC"
        return 0
    fi
    
    printf "    %s Installing %s...\n" "$INFO" "$pkg"
    
    case "$PKG_MANAGER" in
        pacman)
            sudo pacman -S --noconfirm "$pkg" &>/dev/null && \
                printf "    %s %s installed\n" "$SUCCESS" "$pkg" || \
                printf "    %s Failed to install %s\n" "$FAIL" "$pkg"
            ;;
        brew)
            brew install "$pkg" &>/dev/null && \
                printf "    %s %s installed\n" "$SUCCESS" "$pkg" || \
                printf "    %s Failed to install %s\n" "$FAIL" "$pkg"
            ;;
    esac
}

# Install from AUR (Arch) or alternative for macOS
install_aur() {
    local pkg="$1"
    local alt_brew="${2:-}"
    
    case "$PKG_MANAGER" in
        pacman)
            if is_installed "$pkg"; then
                printf "    %s%s already installed%s\n" "$DIM" "$pkg" "$NC"
                return 0
            fi
            printf "    %s Installing %s (AUR)...\n" "$INFO" "$pkg"
            yay -S --noconfirm "$pkg" &>/dev/null && \
                printf "    %s %s installed\n" "$SUCCESS" "$pkg" || \
                printf "    %s Failed to install %s\n" "$FAIL" "$pkg"
            ;;
        brew)
            if [ -n "$alt_brew" ]; then
                install_pkg "$alt_brew"
            else
                print_warn "$pkg not available on macOS"
            fi
            ;;
    esac
}

# Install cask (macOS only)
install_cask() {
    local cask="$1"
    local alt_pkg="${2:-}"
    
    if [ "$PKG_MANAGER" = "brew" ]; then
        if brew list --cask "$cask" &>/dev/null; then
            printf "    %s%s already installed%s\n" "$DIM" "$cask" "$NC"
            return 0
        fi
        printf "    %s Installing %s...\n" "$INFO" "$cask"
        brew install --cask "$cask" &>/dev/null && \
            printf "    %s %s installed\n" "$SUCCESS" "$cask" || \
            printf "    %s Failed to install %s\n" "$FAIL" "$cask"
    elif [ -n "$alt_pkg" ]; then
        install_pkg "$alt_pkg"
    fi
}

# Map package names across distros
# Usage: get_pkg "generic_name"
# Returns distro-specific package name
get_pkg() {
    local generic="$1"
    local arch_pkg brew_pkg
    
    # Package mappings for Arch and macOS
    case "$generic" in
        fd)         arch_pkg="fd";         brew_pkg="fd" ;;
        ripgrep)    arch_pkg="ripgrep";    brew_pkg="ripgrep" ;;
        bat)        arch_pkg="bat";        brew_pkg="bat" ;;
        eza)        arch_pkg="eza";        brew_pkg="eza" ;;
        btop)       arch_pkg="btop";       brew_pkg="btop" ;;
        lazygit)    arch_pkg="lazygit";    brew_pkg="lazygit" ;;
        neovim)     arch_pkg="neovim";     brew_pkg="neovim" ;;
        tmux)       arch_pkg="tmux";       brew_pkg="tmux" ;;
        zsh)        arch_pkg="zsh";        brew_pkg="zsh" ;;
        kitty)      arch_pkg="kitty";      brew_pkg="kitty" ;;
        fzf)        arch_pkg="fzf";        brew_pkg="fzf" ;;
        stow)       arch_pkg="stow";       brew_pkg="stow" ;;
        tree)       arch_pkg="tree";       brew_pkg="tree" ;;
        git)        arch_pkg="git";        brew_pkg="git" ;;
        curl)       arch_pkg="curl";       brew_pkg="curl" ;;
        wget)       arch_pkg="wget";       brew_pkg="wget" ;;
        unzip)      arch_pkg="unzip";      brew_pkg="unzip" ;;
        gcc)        arch_pkg="gcc";        brew_pkg="gcc" ;;
        make)       arch_pkg="make";       brew_pkg="make" ;;
        cmake)      arch_pkg="cmake";      brew_pkg="cmake" ;;
        python)     arch_pkg="python";     brew_pkg="python@3" ;;
        python-pip) arch_pkg="python-pip"; brew_pkg="python@3" ;;
        nodejs)     arch_pkg="nodejs";     brew_pkg="node" ;;
        npm)        arch_pkg="npm";        brew_pkg="node" ;;
        *)          echo "$generic"; return ;;
    esac
    
    # Return the appropriate package name for current package manager
    case "$PKG_MANAGER" in
        pacman) echo "$arch_pkg" ;;
        brew)   echo "$brew_pkg" ;;
        *)      echo "$generic" ;;
    esac
}

# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║                              MAIN SCRIPT                                   ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# Select distro first
select_distro

#==============================================================================
# SECTION 1: System Update & Package Manager Setup
#==============================================================================

print_header "System Preparation"

if prompt_yes_no "Update system packages?"; then
    print_info "Updating package manager..."
    case "$PKG_MANAGER" in
        pacman)
            sudo pacman -Syyu --noconfirm
            ;;
        brew)
            brew update && brew upgrade
            ;;
    esac
    print_success "System updated"
fi

# Install AUR helper for Arch
if [ "$PKG_MANAGER" = "pacman" ]; then
    if ! command -v yay &>/dev/null; then
        print_info "Installing yay (AUR helper)..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm
        cd - &>/dev/null
        print_success "yay installed"
    else
        printf "%syay already installed%s\n" "$DIM" "$NC"
    fi
fi

# Install Homebrew for macOS
if [ "$DISTRO" = "macos" ]; then
    if ! command -v brew &>/dev/null; then
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        print_success "Homebrew installed"
    else
        printf "%sHomebrew already installed%s\n" "$DIM" "$NC"
    fi
fi

#==============================================================================
# SECTION 2: Basic Tools
#==============================================================================

print_header "Basic Tools & Dependencies"

print_section "Essential CLI Tools"
print_dep "curl, wget, tree, unzip, tar"

if prompt_yes_no "Install essential CLI tools?"; then
    for pkg in curl wget tree unzip; do
        install_pkg "$(get_pkg "$pkg")"
    done
fi

print_section "Development Tools"
print_dep "git, gcc, make, cmake, stow"

if prompt_yes_no "Install development tools?"; then
    install_pkg "$(get_pkg git)"
    install_pkg "$(get_pkg gcc)"
    install_pkg "$(get_pkg make)"
    install_pkg "$(get_pkg cmake)"
    install_pkg "$(get_pkg stow)"
fi

print_section "Modern CLI Replacements"
print_dep "eza (ls), bat (cat), zoxide (cd), fd (find), ripgrep (grep)"

if prompt_yes_no "Install modern CLI tools?"; then
    install_pkg "$(get_pkg eza)"
    install_pkg "$(get_pkg bat)"
    install_pkg zoxide
    install_pkg "$(get_pkg fd)"
    install_pkg "$(get_pkg ripgrep)"
    install_pkg "$(get_pkg fzf)"
    install_pkg "$(get_pkg btop)"
fi

#==============================================================================
# SECTION 3: SSH Key
#==============================================================================

print_header "SSH Configuration"

if prompt_yes_no "Generate a new SSH key?"; then
    printf "%sEnter email for SSH key: %s" "$CYAN" "$NC"
    read -r ssh_email
    printf "%sEnter key name (default: id_ed25519): %s" "$CYAN" "$NC"
    read -r ssh_name
    ssh_name=${ssh_name:-id_ed25519}
    
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/"$ssh_name"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/"$ssh_name"
    
    print_success "SSH key generated: ~/.ssh/$ssh_name"
    printf "%sAdd this public key to GitHub/GitLab:%s\n" "$YELLOW" "$NC"
    cat ~/.ssh/"$ssh_name".pub
    printf "\n"
fi

#==============================================================================
# SECTION 4: Git Configuration
#==============================================================================

print_header "Git Configuration"

if prompt_yes_no "Configure Git user?"; then
    printf "%sGit username: %s" "$CYAN" "$NC"
    read -r git_name
    printf "%sGit email: %s" "$CYAN" "$NC"
    read -r git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global core.editor "nvim"
    git config --global init.defaultBranch "main"
    
    print_success "Git configured for $git_name <$git_email>"
fi

#==============================================================================
# SECTION 5: Node.js & NVM
#==============================================================================

print_header "Node.js Environment"

print_section "NVM (Node Version Manager)"
print_dep "Required for: LSP servers, Neovim plugins, web development"

if prompt_yes_no "Install NVM and Node.js?"; then
    if [ ! -d "$HOME/.nvm" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        print_success "NVM installed"
    else
        printf "%sNVM already installed%s\n" "$DIM" "$NC"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    fi
    
    print_info "Installing latest Node.js LTS..."
    nvm install --lts
    nvm use --lts
    
    print_info "Installing pnpm..."
    npm install -g pnpm
    
    print_success "Node.js $(node -v) installed with pnpm"
fi

#==============================================================================
# SECTION 6: Fonts
#==============================================================================

print_header "Nerd Fonts"

print_section "Required Fonts"
print_dep "CaskaydiaCove Nerd Font - Used by Kitty, Waybar, Neovim"
print_dep "MesloLGS Nerd Font - Used by Powerlevel10k"

if prompt_yes_no "Install Nerd Fonts?"; then
    case "$PKG_MANAGER" in
        pacman)
            install_pkg "ttf-cascadia-code-nerd"
            install_pkg "ttf-meslo-nerd"
            install_pkg "ttf-jetbrains-mono-nerd"
            ;;
        brew)
            brew tap homebrew/cask-fonts 2>/dev/null || true
            install_cask "font-caskaydia-cove-nerd-font"
            install_cask "font-meslo-lg-nerd-font"
            install_cask "font-jetbrains-mono-nerd-font"
            ;;
    esac
    
    # Refresh font cache (Linux only)
    if [ "$DISTRO" = "arch" ]; then
        fc-cache -fv &>/dev/null
    fi
    print_success "Fonts installed"
fi

#==============================================================================
# SECTION 7: Zsh
#==============================================================================

print_header "Zsh Shell"

print_section "Zsh + Oh My Zsh + Powerlevel10k"
print_dep "zsh - Shell"
print_dep "oh-my-zsh - Framework"
print_dep "powerlevel10k - Theme"
print_dep "zsh-autosuggestions - Fish-like suggestions"
print_dep "zsh-syntax-highlighting - Command highlighting"

if prompt_yes_no "Install Zsh environment?"; then
    install_pkg "$(get_pkg zsh)"
    
    # Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed"
    fi
    
    # Powerlevel10k
    P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [ ! -d "$P10K_DIR" ]; then
        print_info "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        print_success "Powerlevel10k installed"
    fi
    
    # Plugins
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    fi
    
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    fi
    
    print_success "Zsh plugins installed"
    
    if prompt_yes_no "Set Zsh as default shell?"; then
        chsh -s "$(which zsh)"
        print_success "Zsh set as default shell (restart to apply)"
    fi
fi

#==============================================================================
# SECTION 8: Kitty Terminal
#==============================================================================

print_header "Kitty Terminal"

print_section "GPU-Accelerated Terminal"
print_dep "kitty - Terminal emulator"
print_dep "Supports: True color, ligatures, images"

if prompt_yes_no "Install Kitty?"; then
    case "$PKG_MANAGER" in
        pacman)
            install_pkg kitty
            ;;
        brew)
            install_cask "kitty"
            ;;
    esac
    print_success "Kitty installed"
fi

#==============================================================================
# SECTION 9: Tmux
#==============================================================================

print_header "Tmux"

print_section "Terminal Multiplexer"
print_dep "tmux - Session manager"
print_dep "tpm - Plugin manager"
print_dep "Plugins: catppuccin, sensible, yank, floax, fzf"

if prompt_yes_no "Install Tmux?"; then
    install_pkg "$(get_pkg tmux)"
    
    # TPM
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        print_info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
        print_success "TPM installed"
        print_warn "After first tmux launch, press Ctrl+A then I to install plugins"
    fi
fi

#==============================================================================
# SECTION 10: Hyprland Desktop Environment (Arch Linux only)
#==============================================================================

if [ "$DISTRO" = "arch" ]; then
    print_header "Hyprland Desktop Environment"

    print_section "Wayland Compositor & Tools"
    print_dep "hyprland - Tiling compositor"
    print_dep "waybar - Status bar"
    print_dep "wofi - App launcher"
    print_dep "hyprlock - Lock screen"
    print_dep "hypridle - Idle daemon"
    print_dep "hyprpaper - Wallpaper"
    print_dep "hyprshot - Screenshots"
    print_dep "swayosd - OSD for volume/brightness"
    print_dep "swaync - Notification center"

    if prompt_yes_no "Install Hyprland environment?"; then
        # Core
        install_pkg "hyprland"
        install_pkg "xdg-desktop-portal-hyprland"
        
        # Status bar & launcher
        install_pkg "waybar"
        install_pkg "wofi"
        
        # Hypr ecosystem
        install_pkg "hyprlock"
        install_pkg "hypridle"
        install_pkg "hyprpaper"
        install_aur "hyprshot"
        
        # Notifications & OSD
        install_aur "swayosd-git"
        install_aur "swaync"
        
        # Utilities
        install_pkg "grim"
        install_pkg "slurp"
        install_pkg "wl-clipboard"
        install_pkg "brightnessctl"
        install_pkg "playerctl"
        install_pkg "pamixer"
        install_pkg "bluez"
        install_pkg "bluez-utils"
        install_pkg "blueberry"
        install_pkg "networkmanager"
        install_pkg "nautilus"
        
        print_success "Hyprland environment installed"
    fi
else
    print_header "Window Management (macOS)"
    print_section "Tiling Window Manager"
    print_dep "Rectangle - Window snapping and tiling"
    
    if prompt_yes_no "Install window management tools?"; then
        install_cask "rectangle"
        print_info "For Aerospace (Hyprland-like): https://github.com/nikitabobko/AeroSpace"
    fi
fi

#==============================================================================
# SECTION 11: Yazi File Manager
#==============================================================================

print_header "Yazi File Manager"

print_section "Terminal File Manager"
print_dep "yazi - Blazing fast file manager (Rust)"
print_dep "ffmpegthumbnailer - Video thumbnails"
print_dep "ueberzugpp - Image preview (Linux)"
print_dep "poppler - PDF preview"

if prompt_yes_no "Install Yazi?"; then
    case "$PKG_MANAGER" in
        pacman)
            install_pkg "yazi"
            install_pkg "ffmpegthumbnailer"
            install_aur "ueberzugpp"
            install_pkg "poppler"
            install_pkg "imagemagick"
            ;;
        brew)
            install_pkg "yazi"
            install_pkg "ffmpegthumbnailer"
            install_pkg "poppler"
            install_pkg "imagemagick"
            ;;
    esac
    
    print_success "Yazi installed with preview support"
fi

#==============================================================================
# SECTION 12: Additional Apps
#==============================================================================

print_header "Additional Applications"

if prompt_yes_no "Install Zen Browser?"; then
    case "$PKG_MANAGER" in
        pacman) install_aur "zen-browser-bin" ;;
        brew) install_cask "zen-browser" ;;
    esac
fi

if prompt_yes_no "Install Discord (Vesktop)?"; then
    case "$PKG_MANAGER" in
        pacman) install_aur "vesktop-bin" ;;
        brew) install_cask "vesktop" ;;
    esac
fi

if prompt_yes_no "Install Docker?"; then
    case "$PKG_MANAGER" in
        pacman)
            install_pkg "docker"
            install_pkg "docker-compose"
            sudo systemctl enable docker
            sudo usermod -aG docker "$USER"
            print_warn "Log out and back in for Docker group to apply"
            ;;
        brew)
            install_cask "docker"
            ;;
    esac
fi

#==============================================================================
# SECTION 13: Neovim (Last - Most Dependencies)
#==============================================================================

print_header "Neovim"

print_section "Modern Text Editor"
printf "%sNeovim requires many dependencies for full functionality%s\n\n" "$DIM" "$NC"

print_tool "Core Dependencies"
print_dep "neovim >= 0.10 - Editor"
print_dep "ripgrep - Telescope live grep"
print_dep "fd - Telescope file finder"
print_dep "fzf - Fuzzy finding"

print_tool "LSP Servers (via Mason)"
print_dep "lua-language-server - Lua"
print_dep "typescript-language-server - TypeScript/JavaScript"
print_dep "vue-language-server - Vue"
print_dep "biome - JS/TS linting & formatting"
print_dep "eslint-lsp - ESLint"
print_dep "tailwindcss-language-server - Tailwind"
print_dep "html-lsp, css-lsp - Web"
print_dep "bash-language-server - Shell"

print_tool "Formatters & Linters (via Mason)"
print_dep "prettier - Code formatter"
print_dep "stylua - Lua formatter"
print_dep "markdownlint - Markdown linter"
print_dep "eslint_d - Fast ESLint"

print_tool "Plugin Dependencies"
print_dep "git - Gitsigns, LazyGit"
print_dep "lazygit - Git TUI"
print_dep "nodejs + npm - Copilot, LSP servers"
print_dep "python3 + pip - Some plugins"
print_dep "cargo (Rust) - Some tools"
print_dep "gcc/clang - Treesitter parsers"

print_tool "Clipboard & UI"
print_dep "xclip or wl-clipboard - System clipboard"
print_dep "nerd-fonts - Icons"

echo ""
if prompt_yes_no "Install Neovim and all dependencies?"; then
    # Core
    install_pkg "$(get_pkg neovim)"
    install_pkg "$(get_pkg ripgrep)"
    install_pkg "$(get_pkg fd)"
    install_pkg "$(get_pkg fzf)"
    
    # Build tools for Treesitter
    install_pkg "$(get_pkg gcc)"
    install_pkg "$(get_pkg make)"
    install_pkg "$(get_pkg unzip)"
    
    # Git tools
    install_pkg "$(get_pkg git)"
    install_pkg "$(get_pkg lazygit)"
    
    # Python
    install_pkg "$(get_pkg python)"
    install_pkg "$(get_pkg python-pip)"
    case "$PKG_MANAGER" in
        pacman) install_pkg "python-pynvim" ;;
        brew) pip3 install --user pynvim 2>/dev/null || true ;;
    esac
    
    # Clipboard (Linux only)
    if [ "$DISTRO" = "arch" ]; then
        install_pkg "wl-clipboard"
        install_pkg "xclip"
    fi
    
    print_success "Neovim dependencies installed"
    print_info "Mason will auto-install LSP servers on first Neovim launch"
    print_warn "Run :checkhealth in Neovim to verify setup"
fi

#==============================================================================
# SECTION 14: Apply Dotfiles
#==============================================================================

print_header "Apply Dotfiles"

DOTFILES_DIR="$HOME/Dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    if prompt_yes_no "Apply dotfiles using GNU Stow?"; then
        cd "$DOTFILES_DIR"
        
        print_info "Stowing configurations..."
        
        # Backup existing configs
        for config in .zshrc .p10k.zsh; do
            [ -f "$HOME/$config" ] && [ ! -L "$HOME/$config" ] && mv "$HOME/$config" "$HOME/$config.backup"
        done
        
        for config in nvim kitty tmux hypr waybar wofi yazi; do
            [ -d "$HOME/.config/$config" ] && [ ! -L "$HOME/.config/$config" ] && \
                mv "$HOME/.config/$config" "$HOME/.config/$config.backup"
        done
        
        stow .
        
        print_success "Dotfiles applied"
        cd - &>/dev/null
    fi
else
    print_warn "Dotfiles directory not found at $DOTFILES_DIR"
    print_info "Clone: git clone https://github.com/Naleeee/Dotfiles.git ~/Dotfiles"
fi

#==============================================================================
# SUMMARY
#==============================================================================

print_header "Installation Complete!"

printf "%s%sNext Steps:%s\n\n" "$GREEN" "$BOLD" "$NC"
printf "  1. %sRestart your terminal%s or run: %ssource ~/.zshrc%s\n" "$CYAN" "$NC" "$DIM" "$NC"
printf "  2. %sConfigure Powerlevel10k%s: %sp10k configure%s\n" "$CYAN" "$NC" "$DIM" "$NC"
printf "  3. %sInstall Tmux plugins%s: Open tmux, press %sCtrl+A, I%s\n" "$CYAN" "$NC" "$DIM" "$NC"
printf "  4. %sLaunch Neovim%s: Mason will install LSP servers automatically\n" "$CYAN" "$NC"
printf "  5. %sCheck Neovim health%s: %s:checkhealth%s\n" "$CYAN" "$NC" "$DIM" "$NC"

if [ "$DISTRO" = "arch" ]; then
    printf "\n"
    printf "%sFor Hyprland: Log out and select Hyprland from your display manager%s\n" "$DIM" "$NC"
fi

printf "\n"
print_success "Happy coding! 🚀"
