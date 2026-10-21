#!/usr/bin/env bash
# Install GUI apps from official distributions (no Homebrew Cask). Safe to re-run.
# Apps update themselves after the initial install.
set -euo pipefail

# install_zip_app <App Name> <zip URL>
install_zip_app() {
  local name="$1" url="$2"
  if [[ -d "/Applications/$name.app" ]]; then
    echo "    $name: already installed"
    return
  fi
  echo "    $name: installing"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL "$url" -o "$tmp/app.zip"
  ditto -xk "$tmp/app.zip" /Applications/
  rm -rf "$tmp"
}

echo "==> Installing GUI apps"
install_zip_app "Visual Studio Code" \
  "https://update.code.visualstudio.com/latest/darwin-universal/stable"

# Expose the `code` CLI
mkdir -p "$HOME/.local/bin"
ln -sfn "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$HOME/.local/bin/code"
