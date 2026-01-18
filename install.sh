#!/bin/bash

echo "Installing dotfiles..."

# Create symlinks for shell configs
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

# Create symlinks for VS Code
mkdir -p ~/Library/Application\ Support/Code/User/
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Create symlinks for Ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/.dotfiles/ghostty/config ~/.config/ghostty/config


echo "Dotfiles installed!"
echo "Don't forget to configure iTerm2 to load preferences from ~/.dotfiles"
