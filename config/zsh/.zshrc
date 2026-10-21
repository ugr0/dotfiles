# Interactive shell
export PATH="$HOME/.local/bin:$PATH"

# mise: activate tools from ~/.config/mise/config.toml and per-project mise.toml
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ghq + fzf: jump to a repository (Ctrl-G)
ghq-cd() {
  local dir
  dir="$(ghq list --full-path | fzf --prompt='repo> ')" || return
  cd "$dir" && zle reset-prompt 2>/dev/null
}
if [[ -o interactive ]]; then
  zle -N ghq-cd
  bindkey '^G' ghq-cd
fi
