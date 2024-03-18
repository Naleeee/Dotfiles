#! /bin/bash

# Foreground Color
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"
CYAN="\e[0;36m"
LIGHT_GREY="\e[0;37m"
GRAY="\e[0;90m"
LIGHT_RED="\e[0;91m"
LIGHT_GREEN="\e[0;92m"
LIGHT_YELLOW="\e[0;93m"
LIGHT_BLUE="\e[0;94m"
LIGHT_MAGENTA="\e[0;95m"
LIGHT_CYAN="\e[0;96m"
WHITE="\e[0;97m"
NOCOLOR="\e[0m"

BOLD_YELLOW="\e[1;93m"
ITALIC_GRAY="\e[3;90m"
CATEGORY="\e[1;92m"

function PromptYesNo {
    local _response
    while true; do
        if [ -n "$1" ]; then
            echo -n "$1"
        else
            echo -n -e "${LIGHT_CYAN}Are you sure${NOCOLOR}"
        fi
        echo -n -e "${LIGHT_CYAN} [Y/n] ? ${NOCOLOR}"
        read -r _response
        case "$_response" in
            [Yy]|"") return 0; break;;
            [Nn]) return 1; break;;
            *) echo -e "${LIGHT_RED}Invalid input, please answer yes or no.${NOCOLOR}";;
        esac
    done
}

echo -e "${BOLD_YELLOW}\nStarting auto setup script for Manjaro !\n${NOCOLOR}"


# Pacman setup
echo -e "${CATEGORY}\nStarting pacman databases sync\n${NOCOLOR}"
sudo pacman -Syyu


# Basic dependencies
echo -e "${CATEGORY}\nInstalling basic tools and dependencies\n${NOCOLOR}"
echo -e "${LIGHT_CYAN}Installing curl${NOCOLOR}"
sudo pacman -S curl
echo -e "${LIGHT_CYAN}Installing tree command${NOCOLOR}"
sudo pacman -S tree
echo -e "${LIGHT_CYAN}Installing npm${NOCOLOR}"
pamac install nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
source ~/.bashrc
nvm install node
echo -e "${LIGHT_CYAN}Installing GNU compilers${NOCOLOR}"
sudo pacman -S gcc
echo -e "${LIGHT_CYAN}Installing make command${NOCOLOR}"
sudo pacman -S make


# Neovim setup
echo -e "${CATEGORY}\nInstalling neovim and dependencies${NOCOLOR}"
echo -e "${ITALIC_GRAY}Source: https://medium.com/thelinux/the-correct-way-to-install-the-neovim-42f3076f9b88\n${NOCOLOR}"
PromptYesNo "Do you want to install Neovim ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting NeoVim installation via app image${NOCOLOR}"
  # Downloading app image
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  # Setting permissions and correct name, location
  chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim

  echo -e "${LIGHT_CYAN}Installing fzf${NOCOLOR}"
  sudo pacman -S fzf
  echo -e "${LIGHT_CYAN}Installing ripgrep${NOCOLOR}"
  sudo pacman -S ripgrep
else
  echo -e "${LIGHT_RED}Skipping Neovim installation${NOCOLOR}"
fi


# Git
echo -e "${CATEGORY}\nSetting up Git${NOCOLOR}"
echo -e "${ITALIC_GRAY}Source: https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/generate-ssh-key-pair.html\n${NOCOLOR}"
echo -e "${LIGHT_CYAN}Setting user info${NOCOLOR}"
git config --global user.email "nthn.lemale@gmail.com"
git config --global user.name "Nale"
echo -e "${LIGHT_CYAN}Setting default editor to nvim${NOCOLOR}"
git config --global core.editor "nvim"
PromptYesNo "Do you want to generate a new ssh key ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Generating ssh key${NOCOLOR}"
  ssh-keygen -t rsa
  echo -e "${LIGHT_BLUE}Please enter your ssh key filename${NOCOLOR}"
  read -p "> " sshKeyName
  mkdir --parents ~/.ssh/; mv ${sshKeyName} $_
  mv ${sshKeyName}.pub ~/.ssh/
  eval $(ssh-agent -s) ssh-add ~/.ssh/${sshKeyName}
else
  echo -e "${LIGHT_RED}Skipping ssh key generation${NOCOLOR}"
fi


# Brave Browser
echo -e "${CATEGORY}\nInstalling Brave Browser\n${NOCOLOR}"
PromptYesNo "Do you want to install Brave Browser ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting Brave Browser installation${NOCOLOR}"
  sudo pacman --needed -S brave-browser
else
  echo -e "${LIGHT_RED}Skipping Brave Browser installation${NOCOLOR}"
fi


# Kitty
echo -e "${CATEGORY}\nInstalling Kitty terminal\n${NOCOLOR}"
PromptYesNo "Do you want to install Kitty ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting Kitty installation${NOCOLOR}"
  sudo pacman -S kitty
else
  echo -e "${LIGHT_RED}Skipping Kitty installation${NOCOLOR}"
fi


# Tmux
echo -e "${CATEGORY}\nInstalling tmux\n${NOCOLOR}"
PromptYesNo "Do you want to install tmux ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting tmux installation${NOCOLOR}"
  sudo pacman -S tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo -e "${LIGHT_RED}Skipping tmux installation${NOCOLOR}"
fi


# Docker
echo -e "${CATEGORY}\nInstalling Docker\n${NOCOLOR}"
PromptYesNo "Do you want to install Docker?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting Docker installation${NOCOLOR}"
  sudo pacman --needed -S docker
else
  echo -e "${LIGHT_RED}Skipping Docker installation${NOCOLOR}"
fi


# Discord
echo -e "${CATEGORY}\nInstalling Discord\n${NOCOLOR}"
PromptYesNo "Do you want to install Discord?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting Discord installation${NOCOLOR}"
  sudo pacman -S discord
else
  echo -e "${LIGHT_RED}Skipping Discord installation${NOCOLOR}"
fi


# Zsh
echo -e "${CATEGORY}\nInstalling Zsh and Oh My Zsh${NOCOLOR}"
echo -e "${ITALIC_GRAY}Source: https://gist.github.com/yovko/becf16eecd3a1f69a4e320a95689249e\n${NOCOLOR}"
PromptYesNo "Do you want to install Zsh?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting Zsh installation${NOCOLOR}"
  sudo pacman -S zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo -e "${LIGHT_CYAN}Setting Zsh as default shell${NOCOLOR}"
  chsh -s $(which zsh)
  zsh
  echo -e "${LIGHT_CYAN}Cloning plugins for zsh${NOCOLOR}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo -e "${LIGHT_CYAN}Cloning p10k for more personalization${NOCOLOR}"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  source ~/.zshrc
else
  echo -e "${LIGHT_RED}Skipping Zsh setup${NOCOLOR}"
fi



# Move to next monitor
echo -e "${CATEGORY}\nInstalling a move to next monitor handler${NOCOLOR}"
echo -e "${ITALIC_GRAY}Source: https://github.com/AlexisBRENON/ewmh_m2m\n${NOCOLOR}"
PromptYesNo "Is pip installed ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting pip installation${NOCOLOR}"
  sudo pacman -S python-pip
else
  echo -e "${LIGHT_RED}Skipping pip installation${NOCOLOR}"
fi
PromptYesNo "Do you want to install ewmh_m2m ?"
if [[ $? == 0 ]]; then
  echo -e "${LIGHT_CYAN}Starting ewmh_m2m and dependencies installation${NOCOLOR}"
  pip install ewmh-m2m --break-system-packages
  pip install setuptools --break-system-packages
  echo -e "${LIGHT_CYAN}You still need to add the shortcuts to Shortcuts settings with the new move-to-monitor command, for exemple for left direction:${NOCOLOR}"
  echo -e "${LIGHT_CYAN}\$ move-to-monitor --direction EAST${NOCOLOR}"
else
  echo -e "${LIGHT_RED}Skipping move to next monitor setup${NOCOLOR}"
fi
