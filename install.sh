#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
cd "$DOTFILES"

echo "══════════════════════════════════════"
echo "  Dotfiles Installer"
echo "══════════════════════════════════════"

# ── Phase 1: Homebrew ──
echo ""
echo ">> Phase 1: Installing dependencies..."
brew bundle --file="$DOTFILES/Brewfile"

# ── Phase 2: tmux plugin manager ──
echo ""
echo ">> Phase 2: tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "   Installed tpm. Run 'prefix + I' in tmux to install plugins."
else
  echo "   tpm already installed."
fi

# ── Phase 3: Stow safe packages (no conflicts) ──
echo ""
echo ">> Phase 3: Stowing configs that won't conflict..."

for pkg in aerospace ghostty atuin scripts; do
  echo "   stow $pkg"
  stow --dotfiles "$pkg"
done

# Starship: back up existing file if it's not a symlink
if [ -f "$HOME/.config/starship.toml" ] && [ ! -L "$HOME/.config/starship.toml" ]; then
  echo "   Backing up existing starship.toml -> starship.toml.bak"
  mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.bak"
fi
echo "   stow starship"
stow --dotfiles starship

# Git: back up existing config if needed
if [ -f "$HOME/.config/git/ignore" ] && [ ! -L "$HOME/.config/git/ignore" ]; then
  echo "   Backing up existing git ignore -> git/ignore.bak"
  mv "$HOME/.config/git/ignore" "$HOME/.config/git/ignore.bak"
fi
echo "   stow git"
stow --dotfiles git

# ── Phase 4: Claude Code ──
echo ""
echo ">> Phase 4: Claude Code global config..."
mkdir -p "$HOME/.claude"

# notify.sh (hook script for desktop notifications)
ln -sfn "$DOTFILES/claude-setup/notify.sh" "$HOME/.claude/notify.sh"
echo "   Linked ~/.claude/notify.sh -> dotfiles"

# rules directory (global instructions, split by topic)
if [ -d "$HOME/.claude/rules" ] && [ ! -L "$HOME/.claude/rules" ]; then
  echo "   Backing up existing rules -> rules.bak"
  mv "$HOME/.claude/rules" "$HOME/.claude/rules.bak"
fi
ln -sfn "$DOTFILES/claude-setup/rules" "$HOME/.claude/rules"
echo "   Linked ~/.claude/rules -> dotfiles"

# settings.json (hooks, plugins, permissions)
if [ -f "$HOME/.claude/settings.json" ] && [ ! -L "$HOME/.claude/settings.json" ]; then
  echo "   Backing up existing settings.json -> settings.json.bak"
  mv "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.bak"
fi
ln -sfn "$DOTFILES/claude-setup/settings.json" "$HOME/.claude/settings.json"
echo "   Linked ~/.claude/settings.json -> dotfiles"

# skills directory
if [ -d "$HOME/.claude/skills" ] && [ ! -L "$HOME/.claude/skills" ]; then
  echo "   Backing up existing skills -> skills.bak"
  mv "$HOME/.claude/skills" "$HOME/.claude/skills.bak"
fi
ln -sfn "$DOTFILES/claude-setup/skills" "$HOME/.claude/skills"
echo "   Linked ~/.claude/skills -> dotfiles"

echo ""
echo "══════════════════════════════════════"
echo "  Safe packages installed!"
echo "══════════════════════════════════════"
echo ""
echo "The following require removing old symlinks first."
echo "Switch them over when you're ready:"
echo ""
echo "  # Switch zsh (replaces oh-my-zsh + p10k with starship)"
echo "  rm ~/.zshrc && cd $DOTFILES && stow --dotfiles zsh"
echo ""
echo "  # Switch tmux (adds Catppuccin theme, true color)"
echo "  rm ~/.tmux.conf && cd $DOTFILES && stow --dotfiles tmux"
echo ""
echo "  # Switch nvim (replaces SpaceVim with LazyVim)"
echo "  rm ~/.config/nvim && cd $DOTFILES && stow --dotfiles nvim"
echo ""
echo "After switching, open Ghostty (alt+enter if AeroSpace is running)"
echo "and run 'cheat' for the full keybinding reference."
