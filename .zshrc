# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# -------------
# aliasの設定
# -------------

# VimをNeovimに変更
alias vi="nvim" 
alias vim="nvim"
alias view="nvim -R"

# -------------------
# zshのカスタマイズ
# -------------------

# pushdを自動で行う(popdコマンドで以前のディレクトリに移動できる)
setopt auto_pushd

# pushdの重複を除く
setopt pushd_ignore_dups

# 直前と同じコマンドは履歴に保存しない
setopt hist_ignore_dups

# 他のzshで履歴を共有する
setopt share_history

# 即座に履歴を保存する
setopt inc_append_history

# History設定
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# -----------------
# Zinitの設定
# ----------------
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zstyle ':completion:*:default' menu select=2
# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 補完
zinit light zsh-users/zsh-autosuggestions
# シンタックスハイライト
zinit light zdharma/fast-syntax-highlighting

# -------------------
# starshipの設定
# -------------------
eval "$(starship init zsh)"

# ---------------------
# lsd(rich ls command)
# ---------------------
alias ls='lsd'

# ----------------------------
# Volta(nodeバージョン管理)
# ----------------------------
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# -----------
# pythonのパス
# -----------
export PATH=$PATH:$HOME/Library/Python/3.8/bin

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"