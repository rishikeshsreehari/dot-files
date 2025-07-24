#!/bin/bash

echo "Installing dotfiles..."

# Create symlinks for shell configs
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

# Create symlinks for VS Code
mkdir -p ~/Library/Application\ Support/Code/User/
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Note: iTerm2 preferences are synced directly via iTerm2's built-in sync feature
# Configure in iTerm2 → Preferences → General → "Load preferences from custom folder"

echo "Dotfiles installed!"
echo "Don't forget to configure iTerm2 to load preferences from ~/.dotfiles"
