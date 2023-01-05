#!/bin/bash

if [[ "$*" == *"discord-0.0"* ]]; then
    if [[ "$*" == *".tar.gz"* ]]; then
        echo "Removing old discord folder in /usr/lib64..."
        sudo rm -rf /usr/lib64/discord
        echo "Untar new version..."
        tar -xvf "$1"
        echo "Moving new version to /usr/lib64..."
        sudo mv Discord /usr/lib64/discord
        echo "Updating symbolic link..."
        sudo rm /usr/bin/discord
        sudo ln -s /usr/lib64/discord/Discord /usr/bin/discord
    else
        echo "The provided file is not in the right format."
    fi
else
    echo -e "Usage: $0 [file]\n"
    echo    "file is the new version of discord you want to install."
    echo    "It is a .tar.gz file."
fi
