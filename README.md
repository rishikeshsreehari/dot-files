# Dotfiles

Personal Mac configuration and setup automation.

## Warning

If you're forking this repo, make sure to review and modify all files to match your preferences before running any scripts.

## Fresh Mac Setup

```bash
git clone https://github.com/rishikeshsreehari/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x setup.sh
./setup.sh
```

Restart terminal after completion.

## Daily Workflow

After making changes:

```bash
dotbackup  # Backup configs
dotpush    # Push to GitHub
```




## What's Included

- Homebrew packages (Brewfile)
- Python packages (requirements.txt)
- Shell config (zsh, git, nano)
- App configs via Mackup (VSCode, Ghostty, iTerm2)
- macOS system preferences

## Commands

```bash
dotfiles       # Navigate to dotfiles directory
dotbackup      # Backup all configurations
dotpush        # Commit and push changes
dotpull        # Pull latest changes
dotstatus      # Check git status
```

## Manual Steps

1. Restart terminal
2. Sign into accounts (1Password, iCloud, etc.)
3. Configure app-specific settings as needed
