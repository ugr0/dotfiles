#!/usr/bin/env bash
# Install GUI apps from official distributions (no Homebrew Cask). Safe to re-run.
# Apps update themselves after the initial install.
set -euo pipefail

# Download URL resolvers (only called when the app is not installed yet)
url_vscode()  { echo "https://update.code.visualstudio.com/latest/darwin-universal/stable"; }
url_dia()     { echo "https://releases.diabrowser.com/release/Dia-latest.dmg"; }
url_ghostty() { curl -fsSL https://ghostty.org/download | grep -oE 'https://release\.files\.ghostty\.org/[0-9.]+/Ghostty\.dmg' | head -1; }
url_alttab()  {
  curl -fsSL https://api.github.com/repos/lwouis/alt-tab-macos/releases/latest |
    grep -oE 'https://[^"]+/AltTab-[0-9.]+\.zip' | head -1
}

# install_app <App Name> <zip|dmg> <url resolver>
install_app() {
  local name="$1" kind="$2" resolver="$3"
  if [[ -d "/Applications/$name.app" ]]; then
    echo "    $name: already installed"
    return
  fi
  local url tmp
  url="$("$resolver")"
  if [[ -z "$url" ]]; then
    echo "    $name: download URL not found, skipped" >&2
    return
  fi
  echo "    $name: installing from $url"
  tmp="$(mktemp -d)"
  curl -fsSL "$url" -o "$tmp/app.$kind"
  case "$kind" in
    zip) ditto -xk "$tmp/app.zip" /Applications/ ;;
    dmg)
      hdiutil attach -nobrowse -readonly -quiet -mountpoint "$tmp/mnt" "$tmp/app.dmg"
      ditto "$tmp/mnt/$name.app" "/Applications/$name.app"
      hdiutil detach -quiet "$tmp/mnt"
      ;;
  esac
  rm -rf "$tmp"
}

echo "==> Installing GUI apps"
install_app "Visual Studio Code" zip url_vscode
install_app "Ghostty"            dmg url_ghostty
install_app "AltTab"             zip url_alttab
install_app "Dia"                dmg url_dia

# Expose the `code` CLI
mkdir -p "$HOME/.local/bin"
ln -sfn "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$HOME/.local/bin/code"
