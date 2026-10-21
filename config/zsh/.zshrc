# Interactive shell
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt hist_ignore_dups     # don't record a command identical to the previous one
setopt share_history        # share history between running shells
setopt inc_append_history   # write to history immediately

# Directory stack (cd -<Tab>, popd)
setopt auto_pushd
setopt pushd_ignore_dups

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=2               # select candidates with arrow keys
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'        # case-insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}      # colorize candidates

# mise: activate tools from ~/.config/mise/config.toml and per-project mise.toml
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ghq + fzf: jump to a repository (Ctrl-])
ghq-cd() {
  local dir
  dir="$(ghq list --full-path | fzf --prompt='repo> ')" || return
  cd "$dir" && zle reset-prompt 2>/dev/null
}
if [[ -o interactive ]]; then
  zle -N ghq-cd
  bindkey '^]' ghq-cd
fi
