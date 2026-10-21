# dotfiles

Homebrew を使わない macOS 環境構築。ツール管理は [mise](https://mise.jdx.dev/) に一本化。

## セットアップ

```sh
./install.sh
exec zsh -l
```

1. Xcode Command Line Tools を導入(未導入時のみ)
2. mise を `~/.local/bin` に導入
3. `scripts/link.sh` で設定ファイルを `$HOME` へシンボリックリンク(既存の実ファイルは `*.backup.<日時>` に退避)
4. `mise install` で `config/mise/config.toml` のツールを導入
5. `scripts/apps.sh` で GUI アプリ(VS Code)を公式配布物から導入

マシン固有の Git 設定は `~/.config/git/config.local` に書く(管理対象外):

```sh
git config --file ~/.config/git/config.local user.name  "Your Name"
git config --file ~/.config/git/config.local user.email "you@example.com"
```

## ツールの追加

```sh
mise use -g <tool>@latest   # config.toml に追記されインストールされる
```

## ghq 管理への移行

スクリプトは自身の場所からリポジトリのパスを解決するため、場所を移しても動く。

```sh
gh auth login
gh repo create dotfiles --private --source=. --push
ghq get <user>/dotfiles                       # ~/ghq/github.com/<user>/dotfiles
~/ghq/github.com/<user>/dotfiles/scripts/link.sh  # リンクを張り直す
```

移行後は Ctrl-G(ghq + fzf)でリポジトリへ移動できる。
