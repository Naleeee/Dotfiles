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
ssh-add ~/.ssh/NaleLinuxKey

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

# ---- Grep recursivly ----
alias trouve="grep -rn --exclude-dir=deps --exclude-dir=build --exclude-dir=doxygen --exclude-dir=node_modules --exclude-dir=.next $1"

# ---- Eza (Better ls) ----
alias ls="eza --color=always --icons"
alias l="clear && ls -l"

# ---- Doxygen ----
alias web="doxygen Doxyfile && brave docs/doxygen/html/index.html"

# ---- Doxygen ----
alias t="~/.config/scripts/TmuxStartup.sh"

# pnpm
export PNPM_HOME="/home/nale/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
