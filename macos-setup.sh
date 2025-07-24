#!/bin/bash

echo "Setting up macOS preferences..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Dock optimizations
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.3
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock tilesize -int 36

# Other useful macOS defaults
defaults write com.apple.NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Restart affected applications
killall Finder
killall Dock

echo "macOS preferences updated!"
echo "- Hidden files now visible in Finder"
echo "- Dock set to auto-hide with faster animations"
echo "- Smaller dock size for more screen space"
