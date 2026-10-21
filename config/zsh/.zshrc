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

# Aliases
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias ls="lsd"
alias cat="bat"
alias lg="lazygit"
alias ld="lazydocker"

# mise: activate tools from ~/.config/mise/config.toml and per-project mise.toml
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Tools installed by mise (guarded so the shell still starts before `mise install`)
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"   # prompt
command -v atuin    >/dev/null 2>&1 && eval "$(atuin init zsh)"      # history search (Ctrl-R, Up)

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

# zsh plugins cloned by scripts/zsh-plugins.sh
# (keep last: syntax highlighting wraps widgets defined above)
ZSH_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
[[ -r "$ZSH_PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]] &&
  source "$ZSH_PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
