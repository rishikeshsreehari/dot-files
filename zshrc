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

# Set default editor to nano
export EDITOR="nano"
export VISUAL="nano"

# Custom aliases
alias dotfiles='cd ~/.dotfiles'
alias dotpush='cd ~/.dotfiles && git add . && git commit -m "Update dotfiles" && git push'
alias dotpull='cd ~/.dotfiles && git pull'
alias dotstatus='cd ~/.dotfiles && git status'

# Dotfiles backup workflow
dotbackup() {
    cd ~/.dotfiles
    echo "💾 Backing up configs..."
    brew bundle dump --force --describe
    pip3 freeze > requirements.txt
    mackup backup --force
    
    # All applications in /Applications
    ls /Applications | grep ".app$" > applications-list.txt
    
    # npm global packages (optional)
    npm list -g --depth=0 > npm-globals.txt 2>/dev/null || true

    echo "✅ Backup complete! Run 'dotpush' to commit."
}



alias clr='clear'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='source ~/.zshrc'
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


[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"


# Added by Antigravity
export PATH="/Users/rishikesh/.antigravity/antigravity/bin:$PATH"
# >>> ccm function begin >>>
# CCM: define a shell function that applies exports to current shell
# Ensure no alias/function clashes
unalias ccm 2>/dev/null || true
unset -f ccm 2>/dev/null || true
ccm() {
  local script="/Users/rishikesh/.local/share/ccm/ccm.sh"
  # Fallback search if the installed script was moved or XDG paths changed
  if [[ ! -f "$script" ]]; then
    local default1="${XDG_DATA_HOME:-$HOME/.local/share}/ccm/ccm.sh"
    local default2="$HOME/.ccm/ccm.sh"
    if [[ -f "$default1" ]]; then
      script="$default1"
    elif [[ -f "$default2" ]]; then
      script="$default2"
    fi
  fi
  if [[ ! -f "$script" ]]; then
    echo "ccm error: script not found at $script" >&2
    return 1
  fi

  # All commands use eval to apply environment variables
  case "$1" in
    ""|"help"|"-h"|"--help"|"status"|"st"|"config"|"cfg"|"save-account"|"switch-account"|"list-accounts"|"delete-account"|"current-account"|"debug-keychain"|"project")
      # These commands don't need eval, execute directly
      "$script" "$@"
      ;;
    *)
      # All other commands (model switching) use eval to set environment variables
      eval "$("$script" "$@")"
      ;;
  esac
}

# CCC: Claude Code Commander - switch model and launch Claude Code
# Ensure no alias/function clashes
unalias ccc 2>/dev/null || true
unset -f ccc 2>/dev/null || true
ccc() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ccc <model> [region|variant] [claude-options]"
    echo "       ccc open <provider> [claude-options]"
    echo "       ccc <account> [claude-options]            # Switch account then launch"
    echo "       ccc <model>:<account> [claude-options]"
    echo ""
    echo "Examples:"
    echo "  ccc deepseek                              # Launch with DeepSeek"
    echo "  ccc open kimi                             # Launch with OpenRouter (kimi)"
    echo "  ccc woohelps                              # Switch to 'woohelps' account and launch"
    echo "  ccc claude:work                           # Switch to 'work' account and use Claude"
    echo "  ccc glm --dangerously-skip-permissions    # Launch GLM with options"
    echo ""
    echo "Available models:"
    echo "  Official: deepseek, glm, kimi, qwen, seed|doubao, claude, minimax"
    echo "  OpenRouter: open <provider>"
    echo "  Account:  <account> | claude:<account>"
    return 1
  fi

  local model=""
  local open_provider=""
  local region_arg=""
  local seed_variant=""

  if [[ "$1" == "open" ]]; then
    shift || true
    if [[ $# -lt 1 ]]; then
      echo "Usage: ccc open <provider> [claude-options]"
      return 1
    fi
    model="open"
    open_provider="$1"
    shift || true
  else
    model="$1"
    shift || true
  fi
  
  # Helper: known model keyword
  _is_known_model() {
    case "$1" in
      deepseek|ds|glm|glm5|kimi|kimi2|qwen|minimax|mm|seed|doubao|claude|sonnet|s|open)
        return 0 ;;
      *)
        return 1 ;;
    esac
  }

  # Configure environment via ccm
  if [[ "$model" != "open" ]] && [[ "$model" != *:* ]] && ! _is_known_model "$model" && [[ ! "$model" =~ ^- ]]; then
    # Treat as account name
    local account="$model"
    echo "🔄 Switching account to $account..."
    ccm switch-account "$account" || return 1
    ccm current-account || true
    ccm claude || return 1
  else
    if [[ "$model" == "open" ]]; then
      echo "🔄 Switching to OpenRouter ($open_provider)..."
      ccm open "$open_provider" || return 1
    else
      case "$model" in
        kimi|kimi2|qwen|glm|glm5|minimax|mm)
          if [[ "${1:-}" =~ ^(global|china|cn)$ ]]; then
            region_arg="$1"
            shift || true
          fi
          ;;
        seed|doubao)
          if [[ "${1:-}" =~ ^(doubao|glm|glm5|deepseek|ds|kimi|kimi2)$ ]]; then
            seed_variant="$1"
            shift || true
          fi
          ;;
      esac

      if [[ -n "$seed_variant" ]]; then
        echo "🔄 Switching to $model ($seed_variant)..."
        ccm "$model" "$seed_variant" || return 1
      elif [[ -n "$region_arg" ]]; then
        echo "🔄 Switching to $model ($region_arg)..."
        ccm "$model" "$region_arg" || return 1
      else
        echo "🔄 Switching to $model..."
        ccm "$model" || return 1
      fi
    fi
  fi

  # Collect additional Claude Code arguments
  local claude_args=("$@")

  echo ""
  echo "🚀 Launching Claude Code..."
  echo "   Model: $ANTHROPIC_MODEL"
  echo "   Base URL: ${ANTHROPIC_BASE_URL:-Default (Anthropic)}"
  echo ""

  # Ensure  CLI exists
  if ! type -p claude >/dev/null 2>&1; then
    echo "❌ 'claude' CLI not found. Install: npm install -g @anthropic-ai/claude-code" >&2
    return 127
  fi

  # Launch Claude Code
  if [[ ${#claude_args[@]} -eq 0 ]]; then
    exec claude
  else
    exec claude "${claude_args[@]}"
  fi
}
# <<< ccm function end <<<

# OpenClaw Hetzner Aliases
alias claw-charlie="ssh -N -L 18789:127.0.0.1:18789 claw"
alias moxie="ssh claw -t \"docker run -it --rm -v /root/.hermes-moxie:/opt/data nousresearch/hermes-agent chat\""
alias moxie="ssh claw -t \"docker exec -it hermes-moxie hermes chat\""
