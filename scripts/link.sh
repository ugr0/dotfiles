#!/usr/bin/env bash
# Create symlinks from $HOME to this repo. Safe to re-run (e.g. after moving the repo under ghq).
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

link() {
  local src="$DOTFILES_DIR/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  # Back up real files once; existing symlinks are simply replaced
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.backup.$(date +%Y%m%d%H%M%S)"
    echo "    backed up $dst"
  fi
  ln -sfn "$src" "$dst"
  echo "    $dst -> $src"
}

echo "==> Linking dotfiles from $DOTFILES_DIR"
link config/zsh/.zshrc       "$HOME/.zshrc"
link config/zsh/.zprofile    "$HOME/.zprofile"
link config/git/config       "$HOME/.config/git/config"
link config/git/ignore       "$HOME/.config/git/ignore"
link config/mise/config.toml "$HOME/.config/mise/config.toml"
link config/starship/starship.toml "$HOME/.config/starship.toml"
link config/ghostty/config "$HOME/.config/ghostty/config"
link config/nvim             "$HOME/.config/nvim"
