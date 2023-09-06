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
PROMPT="\e[1;92m"

PromptYesNo () {
  while true; do
    read -p "> " yn
    case $yn in
      [Yy]* ) return 1; break;;
      [Nn]* ) return 0; break;;
      * ) echo -e "${LIGHT_RED}Please answer yes or no.${NOCOLOR}";;
    esac
  done
}

echo -e "${BOLD_YELLOW}\nStarting auto setup script !\n\n${NOCOLOR}"


# Pacman setup
echo -e "${LIGHT_CYAN}Starting Pacman package databases update\n${NOCOLOR}"
sudo pacman -Syyu


# Snap setup
echo -e "${LIGHT_CYAN}\nInitiating Snap\n${NOCOLOR}"
sudo pacman --needed -S snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap


# Neovim setup
echo -e "${PROMPT}\nDo you want to install Neovim, the only true code editor ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Neovim installation\n${NOCOLOR}"

  sudo snap install nvim --classic
else
  echo -e "${LIGHT_RED}\nSkipping Neovim installation\n${NOCOLOR}"
fi


# Git
git config --global user.email "nthn.lemale@gmail.com"
git config --global user.name "Nale"
git config --global core.editor "nvim"


# Ssh Key generation and login
echo -e "${PROMPT}Do you want to generate a Ssh key ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Ssh key generation\n${NOCOLOR}"

  ssh-keygen -t rsa
  echo -e "${PROMPT}Please enter your ssh key filename${NOCOLOR}"
  read -p "> " sshKeyName
  mv ${sshKeyName} ~/.ssh/
  mv ${sshKeyName}.pub ~/.ssh/
  eval $(ssh-agent -s) ssh-add ~/.ssh/${sshKeyName}
else
  echo -e "${LIGHT_RED}\nSkipping Ssh key generation\n${NOCOLOR}"
fi


# Brave setup
echo -e "${PROMPT}Do you want to install Brave Browser ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Brave Browser install\n${NOCOLOR}"

  sudo pacman --needed -S brave-browser
else
  echo -e "${LIGHT_RED}\nSkipping Brave Browser installation\n${NOCOLOR}"
fi


# Paru AUR helper
echo -e "${PROMPT}Do you want to install Paru AUR helper ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Paru AUR helper install\n${NOCOLOR}"

  sudo pacman --needed -S --needed base-devel git
  git clone https://aur.archlinux.org/paru.git ~/
  cd ~/paru/
  makepkg -si
  cd ~
else
  echo -e "${LIGHT_RED}\nSkipping Paru AUR helper install\n${NOCOLOR}"
fi


# Terminator
echo -e "${PROMPT}Do you want to install Terminator terminal ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Terminator terminal install\n${NOCOLOR}"

  paru terminator --bottomup
else
  echo -e "${LIGHT_RED}\nSkipping Terminator terminal install\n${NOCOLOR}"
fi


# Tree command
echo -e "${PROMPT}Do you want to install Tree command ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Tree command install\n${NOCOLOR}"

  paru tree --bottomup
else
  echo -e "${LIGHT_RED}\nSkipping Tree command install\n${NOCOLOR}"
fi


# Docker
echo -e "${LIGHT_CYAN}\nStarting Docker install\n${NOCOLOR}"
sudo pacman --needed -S docker


# Figma
echo -e "${PROMPT}\nDo you want to install Figma ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Figma install\n${NOCOLOR}"

  paru tree --bottomup
else
  echo -e "${LIGHT_RED}\nSkipping Figma install\n${NOCOLOR}"
fi


# Discord
echo -e "${PROMPT}Do you want to install Discord ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Discord install\n${NOCOLOR}"

  paru discord --bottomup
else
  echo -e "${LIGHT_RED}\nSkipping Discord install\n${NOCOLOR}"
fi


# Teams
echo -e "${PROMPT}Do you want to install Teams ? [y/n]${NOCOLOR}"
PromptYesNo
if [[ $? == 1 ]]; then
  echo -e "${LIGHT_CYAN}\nStarting Teams install\n${NOCOLOR}"

  paru teams --bottomup
else
  echo -e "${LIGHT_RED}\nSkipping Teams install\n${NOCOLOR}"
fi


# Zsh
echo -e "${LIGHT_CYAN}\nStarting Docker install\n${NOCOLOR}"
sudo pacman -Syu zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
chsh -s $(which zsh)
zsh
