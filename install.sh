#!/usr/bin/env bash
# Bootstrap a new Mac without Homebrew: Xcode CLT -> mise -> symlinks -> tools
set -euo pipefail

# Resolve repo location from this script so it works wherever the repo lives
# (e.g. ~/workspace/make-env/dotfiles now, ~/ghq/github.com/<user>/dotfiles later)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

# 1. Xcode Command Line Tools (provides git, clang, etc.)
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools"
  xcode-select --install
  echo "Re-run this script after the installation finishes."
  exit 1
fi

# 2. mise (installed to ~/.local/bin/mise)
export PATH="$HOME/.local/bin:$PATH"
if ! command -v mise >/dev/null 2>&1; then
  echo "==> Installing mise"
  curl -fsSL https://mise.run | sh
fi

# 3. Symlink dotfiles into $HOME
"$DOTFILES_DIR/scripts/link.sh"

# 4. Install tools declared in ~/.config/mise/config.toml
echo "==> Installing tools with mise"
mise install

# 5. GUI apps
"$DOTFILES_DIR/scripts/apps.sh"

echo "==> Done. Restart your shell: exec zsh -l"
