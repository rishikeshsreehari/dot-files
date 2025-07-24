#!/bin/bash

echo "Setting up macOS preferences..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Other useful macOS defaults
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Restart affected applications
killall Finder
killall Dock

echo "macOS preferences updated!"
