#!/bin/bash

set -e

echo "🚀 Starting Mac setup for Rishikesh..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Install Mackup
if ! command -v mackup &> /dev/null; then
    echo "📦 Installing Mackup..."
    brew install mackup
fi

# Install from Brewfile
echo "🍺 Installing apps from Brewfile..."
brew bundle --file=~/.dotfiles/Brewfile

# Install Python packages
echo "🐍 Installing Python packages..."
pip3 install -r ~/.dotfiles/requirements.txt

# Setup dotfiles
echo "🔗 Setting up dotfiles..."
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/nanorc ~/.nanorc

# Restore Mackup configs
echo "📋 Restoring app configs..."
mackup restore

# Apply macOS preferences
echo "⚙️ Configuring macOS..."
bash ~/.dotfiles/macos-setup.sh

echo "✅ Setup complete! Restart terminal and sign into accounts."
