# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ---- Theme ----
ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# ---- Plugins ----
plugins=(
    git
    dirhistory
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-bat
)

# Setup the fuck plugin
# eval $(thefuck --alias)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Log to git upon sourcing
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/NaleComptastarKey

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/bin/nvim/
export PATH=$PATH:~/.config/scripts/

# -----------------
# ---- Aliases ----
# -----------------

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- NeoVim ----
alias v="nvim"

# ---- OpenCode ----
alias clip="~/.config/scripts/ClipboardScreenshot.sh"

# ---- Yazi ----
alias y="yazi"

# ---- Git ----
alias gs="git switch"
alias gb="git branch"
alias gm="git merge"
alias gl="git pull"
alias fdp="git blame"
alias gps="git push --set-upstream origin"
gnb() {
    git branch "$1"
    git switch "$1"
    git push --set-upstream origin "$1"
}
alias glog="eval $(ssh-agent -s) ssh-add ~/.ssh/NaleLinuxKey"
alias fsb="~/.config/scripts/FuzzySearchBranch.sh"
alias fsc="~/.config/scripts/FuzzySearchCommits.sh"

# ---- Docker ----
alias dps="docker ps -s"
alias dpsa="docker ps -a -s"
alias dkr="docker kill $(docker ps -q)"
alias dks="docker rm $(docker ps -a -q)"
alias drmi="docker rmi $(docker images -q)"
alias de="docker exec -i -t /bin/bash $1"
alias des="docker exec -i -t -u root /bin/bash $1"
alias dh="echo \"Docker aliases usage:\"
          echo \"   - dps: Display currently running containers with sizes\"
          echo \"   - dpsa: Display every containers with sizes\"
          echo \"   - dkr: Kill every currently running container\"
          echo \"   - dks: Remove every stopped containers\"
          echo \"   - drmi: Remove every images\"
          echo \"   - de: Execute the provided container with /bin/bash\"
          echo \"   - des: Same as de but with root privileges\""

# ---- Comptastar ----
alias client="turbo web#dev"
alias api="turbo api#dev"
alias admin="pnpm dev:admin"
pull() {
    cd apps/api
    pnpm prisma db pull
    pnpm prisma db push
    pnpm prisma generate
    cd ...
}

# ---- Grep recursivly ----
alias trouve="grep -rn --exclude-dir=deps --exclude-dir=build --exclude-dir=doxygen --exclude-dir=node_modules --exclude-dir=.next $1"

# ---- Eza (Better ls) ----
alias ls="eza --color=always --icons"
alias l="clear && ls -l"

# ---- Doxygen ----
alias web="doxygen Doxyfile && brave docs/doxygen/html/index.html"

# ---- Doxygen ----
alias t="~/.config/scripts/TmuxStartup.sh"

# ---- HyprSpace (Window Manager) ----
alias hse="hyprspace enable on"              # Enable HyprSpace
alias hsd="hyprspace enable off"             # Disable HyprSpace
alias hst="hyprspace enable toggle"          # Toggle HyprSpace
alias hsr="hyprspace reload-config"          # Reload config
alias hsl="hyprspace list-windows"           # List all windows
alias hsa="hyprspace list-apps"              # List all apps (for app-id)
alias hsw="hyprspace list-workspaces"        # List workspaces

# ---- AutoRaise (Focus follows mouse) ----
alias are="open -a AutoRaise"                                    # Enable AutoRaise
alias ard="pkill -f 'AutoRaise'"                                 # Disable AutoRaise
alias ars="pgrep -f 'AutoRaise' > /dev/null && echo 'AutoRaise: running' || echo 'AutoRaise: stopped'"  # Status

# pnpm
export PNPM_HOME="/Users/nathanlemale/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/Users/nathanlemale/.opencode/bin:$PATH
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"

. "$HOME/.local/bin/env"

# bun completions
[ -s "/Users/nathanlemale/.bun/_bun" ] && source "/Users/nathanlemale/.bun/_bun"

# ---- Catppuccin Mocha palette (sourced from ~/.config/mocha.css) ----
# Single source of truth: edit mocha.css to change colors everywhere.
_mocha="${XDG_CONFIG_HOME:-$HOME/.config}/mocha.css"
_mocha_parse() { grep "@define-color $1 " "$_mocha" | sed 's/.*#\([0-9a-fA-F]\{6\}\).*/\1/'; }
_hex_to_ansi() {
    local hex="${1#\#}"
    printf "38;2;%d;%d;%d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

# Extract palette
_c_mauve=$(_mocha_parse mauve)
_c_blue=$(_mocha_parse blue)
_c_green=$(_mocha_parse green)
_c_red=$(_mocha_parse red)
_c_maroon=$(_mocha_parse maroon)
_c_yellow=$(_mocha_parse yellow)
_c_pink=$(_mocha_parse pink)
_c_teal=$(_mocha_parse teal)
_c_text=$(_mocha_parse text)
_c_subtext1=$(_mocha_parse subtext1)
_c_overlay0=$(_mocha_parse overlay0)
_c_surface0=$(_mocha_parse surface0)
_c_surface1=$(_mocha_parse surface1)
_c_base=$(_mocha_parse base)
_c_rosewater=$(_mocha_parse rosewater)
_c_lavender=$(_mocha_parse lavender)

# Build LS_COLORS from palette
# di=dir, ln=symlink, ex=executable, fi=file, or=broken, pi=pipe, so=socket
# bd/cd=device, su/sg=setuid/setgid, tw/ow=sticky/world-writable, mi=missing
_a_mauve=$(_hex_to_ansi "$_c_mauve")
_a_blue=$(_hex_to_ansi "$_c_blue")
_a_green=$(_hex_to_ansi "$_c_green")
_a_red=$(_hex_to_ansi "$_c_red")
_a_maroon=$(_hex_to_ansi "$_c_maroon")
_a_yellow=$(_hex_to_ansi "$_c_yellow")
_a_pink=$(_hex_to_ansi "$_c_pink")
_a_teal=$(_hex_to_ansi "$_c_teal")
_a_text=$(_hex_to_ansi "$_c_text")
_a_subtext1=$(_hex_to_ansi "$_c_subtext1")
_a_overlay0=$(_hex_to_ansi "$_c_overlay0")

export LS_COLORS="\
di=${_a_mauve}:ln=${_a_blue}:so=${_a_subtext1}:pi=${_a_subtext1}:\
ex=${_a_green}:bd=${_a_maroon}:cd=${_a_maroon}:or=${_a_red}:mi=${_a_red}:\
su=${_a_pink}:sg=${_a_pink}:tw=${_a_teal}:ow=${_a_teal}:st=${_a_mauve}:\
fi=${_a_text}:\
*.tar=${_a_pink}:*.tgz=${_a_pink}:*.arc=${_a_pink}:*.arj=${_a_pink}:\
*.taz=${_a_pink}:*.lha=${_a_pink}:*.lz4=${_a_pink}:*.lzh=${_a_pink}:\
*.lzma=${_a_pink}:*.tlz=${_a_pink}:*.txz=${_a_pink}:*.tzo=${_a_pink}:\
*.t7z=${_a_pink}:*.zip=${_a_pink}:*.z=${_a_pink}:*.dz=${_a_pink}:\
*.gz=${_a_pink}:*.lrz=${_a_pink}:*.lz=${_a_pink}:*.lzo=${_a_pink}:\
*.xz=${_a_pink}:*.zst=${_a_pink}:*.tzst=${_a_pink}:*.bz2=${_a_pink}:\
*.bz=${_a_pink}:*.tbz=${_a_pink}:*.tbz2=${_a_pink}:*.tz=${_a_pink}:\
*.deb=${_a_pink}:*.rpm=${_a_pink}:*.jar=${_a_pink}:*.war=${_a_pink}:\
*.ear=${_a_pink}:*.rar=${_a_pink}:*.7z=${_a_pink}:*.cab=${_a_pink}:\
*.jpg=${_a_yellow}:*.jpeg=${_a_yellow}:*.mjpg=${_a_yellow}:\
*.mjpeg=${_a_yellow}:*.gif=${_a_yellow}:*.bmp=${_a_yellow}:\
*.pbm=${_a_yellow}:*.pgm=${_a_yellow}:*.ppm=${_a_yellow}:\
*.tga=${_a_yellow}:*.xbm=${_a_yellow}:*.xpm=${_a_yellow}:\
*.tif=${_a_yellow}:*.tiff=${_a_yellow}:*.png=${_a_yellow}:\
*.svg=${_a_yellow}:*.svgz=${_a_yellow}:*.webp=${_a_yellow}:*.ico=${_a_yellow}:\
*.mov=${_a_red}:*.mpg=${_a_red}:*.mpeg=${_a_red}:*.m2v=${_a_red}:\
*.mkv=${_a_red}:*.webm=${_a_red}:*.mp4=${_a_red}:*.m4v=${_a_red}:\
*.mp4v=${_a_red}:*.vob=${_a_red}:*.qt=${_a_red}:*.wmv=${_a_red}:\
*.asf=${_a_red}:*.avi=${_a_red}:*.fli=${_a_red}:*.flv=${_a_red}:\
*.aac=${_a_green}:*.au=${_a_green}:*.flac=${_a_green}:*.m4a=${_a_green}:\
*.mid=${_a_green}:*.midi=${_a_green}:*.mka=${_a_green}:*.mp3=${_a_green}:\
*.mpc=${_a_green}:*.ogg=${_a_green}:*.ra=${_a_green}:*.wav=${_a_green}:\
*.oga=${_a_green}:*.opus=${_a_green}:*.spx=${_a_green}:*.xspf=${_a_green}:\
*.pdf=${_a_text}:*.doc=${_a_text}:*.docx=${_a_text}:*.xls=${_a_text}:\
*.xlsx=${_a_text}:*.ppt=${_a_text}:*.pptx=${_a_text}:*.odt=${_a_text}:\
*.py=${_a_blue}:*.rb=${_a_blue}:*.pl=${_a_blue}:*.js=${_a_blue}:\
*.ts=${_a_blue}:*.jsx=${_a_blue}:*.tsx=${_a_blue}:*.go=${_a_blue}:\
*.rs=${_a_blue}:*.c=${_a_blue}:*.cpp=${_a_blue}:*.h=${_a_blue}:\
*.hpp=${_a_blue}:*.lua=${_a_blue}:*.sh=${_a_blue}:*.zsh=${_a_blue}:\
*.bash=${_a_blue}:*.fish=${_a_blue}:*.vim=${_a_blue}:*.el=${_a_blue}:\
*.json=${_a_yellow}:*.yaml=${_a_yellow}:*.yml=${_a_yellow}:\
*.toml=${_a_yellow}:*.ini=${_a_yellow}:*.conf=${_a_yellow}:\
*.env=${_a_yellow}:*.xml=${_a_yellow}:\
*.md=${_a_text}:*.txt=${_a_text}:*.rst=${_a_text}:\
*.log=${_a_overlay0}:*.tmp=${_a_overlay0}:*.bak=${_a_overlay0}:\
*.swp=${_a_overlay0}:*.orig=${_a_overlay0}"

# Cache LS_COLORS for tmux-fzf-links (tmux doesn't always inherit shell env)
_ls_colors_cache="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-fzf-links/cached_ls_colors.txt"
if [[ ! -f "$_ls_colors_cache" ]] || [[ "$_mocha" -nt "$_ls_colors_cache" ]]; then
    mkdir -p "$(dirname "$_ls_colors_cache")"
    printenv LS_COLORS > "$_ls_colors_cache"
fi
unset _mocha _ls_colors_cache
unset -f _mocha_parse _hex_to_ansi
unset _c_mauve _c_blue _c_green _c_red _c_maroon _c_yellow _c_pink _c_teal \
      _c_text _c_subtext1 _c_overlay0 _c_surface0 _c_surface1 _c_base \
      _c_rosewater _c_lavender \
      _a_mauve _a_blue _a_green _a_red _a_maroon _a_yellow _a_pink _a_teal \
      _a_text _a_subtext1 _a_overlay0

# Fzf catppuccin theme (sourced from ~/.config/mocha.css)
_mocha="${XDG_CONFIG_HOME:-$HOME/.config}/mocha.css"
_mc() { grep "@define-color $1 " "$_mocha" | sed 's/.*\(#[0-9a-fA-F]\{6\}\).*/\1/'; }
export FZF_DEFAULT_OPTS=" \
--color=bg+:$(_mc surface0),bg:$(_mc base),spinner:$(_mc rosewater),hl:$(_mc red) \
--color=fg:$(_mc text),header:$(_mc red),info:$(_mc mauve),pointer:$(_mc rosewater) \
--color=marker:$(_mc lavender),fg+:$(_mc text),prompt:$(_mc mauve),hl+:$(_mc red) \
--color=selected-bg:$(_mc surface1) \
--color=border:$(_mc overlay0),label:$(_mc text)"
unset _mocha
unset -f _mc

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
