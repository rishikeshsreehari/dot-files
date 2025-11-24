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
# Directory Aliases
alias trackmonk="cd ~/GitHub/trackmonk"
alias trackmonk-s="cd ~/GitHub/trackmonk-site"
# Docker compose aliases
alias dc="docker compose"
alias dcu="docker compose up --build -d"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dcps="docker compose ps"

# journal.txt functions

j() {
    cd ~/GitHub/journal
    
    # Pull latest changes first
    echo "Syncing latest entries..."
    git pull
    
    # Add entry template to end of file
    echo "" >> journal.txt
    echo "---" >> journal.txt
    echo "Date: $(date '+%Y-%m-%d')" >> journal.txt
    echo "Time: $(date '+%H:%M')" >> journal.txt
    echo "Tags: " >> journal.txt
    echo "---" >> journal.txt
    echo "" >> journal.txt
    
    # Open nano
    /opt/homebrew/bin/nano + journal.txt
    
    # Always sync after writing
    git add journal.txt
    git commit -m "Journal entry from mac  $(date +%Y-%m-%d)"
    git push
    echo "Journal synced!"
}


jview() {
    cd ~/GitHub/journal
    less journal.txt
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rishikesh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rishikesh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rishikesh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rishikesh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
