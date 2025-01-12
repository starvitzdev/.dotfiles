#!/bin/bash

cd
cp -Tr ~/.config/waybar ~/.dotfiles/waybar
cp -Tr ~/.config/nvim ~/.dotfiles/nvim
cp -Tr ~/.config/sway ~/.dotfiles/sway
cp -Tr ~/.config/fuzzel ~/.dotfiles/fuzzel
cp -Tr /etc/keyd ~/.dotfiles/keyd
cp -Tr ~/.wezterm.lua ~/.dotfiles/.wezterm.lua
cp -Tr ~/.zshrc ~/.dotfiles/.zshrc
cp -Tr ~/wallpaper ~/.dotfiles/wallpaper
cp -Tr ~/.local/bin ~/.dotfiles/bin
cp -Tr ~/.oh-my-posh ~/.dotfiles/.oh-my-posh
cd ~/.dotfiles

pwd
git add .
git commit -m "New settings added"
git push

