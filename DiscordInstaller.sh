#!/bin/bash

rm -rf Desktop/discordln
sudo rm -rf /usr/lib64/discord
tar -xvf "$1"
sudo mv Discord /usr/lib64/discord
ln -s /usr/lib64/discord/Discord Desktop/discordln
