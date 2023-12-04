#! /bin/bash

RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
NOCOLOR="\e[0m"

if [[ "$*" == *"discord-0.0"* ]]; then
    if [[ "$*" == *".tar.gz"* ]]; then
        echo -e "${GREEN}Removing old discord folder in /usr/lib64${NOCOLOR}"
        sudo rm -rf /usr/lib64/discord
        echo -e "${GREEN}Untar new version${NOCOLOR}"
        tar -xvf "$1"
        echo -e "${GREEN}Moving new version to /usr/lib64${NOCOLOR}"
        sudo mv Discord /usr/lib64/discord
        echo -e "${GREEN}Updating symbolic link${NOCOLOR}"
        sudo rm /usr/bin/discord
        sudo ln -s /usr/lib64/discord/Discord /usr/bin/discord
    else
        echo -e "${RED}The provided file is not in the right format.${NOCOLOR}"
    fi
else
    echo -e "${BLUE}Usage:${NOCOLOR} $0 [${YELLOW}file${NOCOLOR}]\n"
    echo -e "${YELLOW}file${NOCOLOR} is the new version of discord you want to install."
    echo -e "It is a .tar.gz file."
fi
