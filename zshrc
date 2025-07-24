# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Prioritize Homebrew packages
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Custom aliases
alias dotfiles='cd ~/.dotfiles'
alias dotpush='cd ~/.dotfiles && git add . && git commit -m "Update dotfiles" && git push'
alias dotpush-brew='cd ~/.dotfiles && brew bundle dump --force && pip3 freeze > requirements.txt && git add . && git commit -m "Update dotfiles, Brewfile, and pip requirements" && git push'
alias dotpull='cd ~/.dotfiles && git pull'
alias dotstatus='cd ~/.dotfiles && git status'
alias clr='clear'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='source ~/.zshrc'
alias gh='cd ~/GitHub'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'

# Python aliases
alias python='python3'
alias py='python3'
alias pip='pip3'
alias pyserver='python3 -m http.server'
alias pyhelp='python3 -c "import this"'
