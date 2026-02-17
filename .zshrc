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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
