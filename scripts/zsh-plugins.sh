#!/usr/bin/env bash
# Clone zsh plugins (no plugin manager). Re-run with --update to pull the latest.
set -euo pipefail

PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
PLUGINS=(
  zdharma-continuum/fast-syntax-highlighting
)

echo "==> Installing zsh plugins"
mkdir -p "$PLUGIN_DIR"
for repo in "${PLUGINS[@]}"; do
  dest="$PLUGIN_DIR/${repo##*/}"
  if [[ ! -d "$dest" ]]; then
    git clone --depth 1 --quiet "https://github.com/$repo.git" "$dest"
    echo "    $repo: installed"
  elif [[ "${1:-}" == "--update" ]]; then
    git -C "$dest" pull --ff-only --quiet
    echo "    $repo: updated"
  else
    echo "    $repo: already installed"
  fi
done
