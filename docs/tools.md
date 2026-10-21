# 導入しているツール

Homebrew は使っていない。「どの仕組みで入れているか」ごとにまとめる。
バージョンは 2026-10-21 の導入時点のもの(`latest` 指定のものは `mise upgrade` で更新される)。

## 前提(OS 側)

| ツール | 入れ方 | 用途 |
|---|---|---|
| Xcode Command Line Tools | `xcode-select --install` | git、clang など。Apple 製の git(`/usr/bin/git`)はここから提供される |

## mise 本体

| ツール | バージョン | 入れ方 | 場所 |
|---|---|---|---|
| [mise](https://mise.jdx.dev/) | 2026.10.15 | `curl https://mise.run \| sh`(公式インストーラ) | `~/.local/bin/mise` |

## mise で管理している CLI ツール

定義: [`config/mise/config.toml`](../config/mise/config.toml)。
`backend` はダウンロード元の種類。`aqua` は GitHub Releases の公式バイナリを、チェックサム等を検証して取得する。

| ツール | バージョン | backend | 用途 |
|---|---|---|---|
| [gh](https://cli.github.com/) | 2.102.0 | aqua:cli/cli | GitHub CLI。git の認証もこれで行う |
| [ghq](https://github.com/x-motemen/ghq) | 1.11.2 | aqua:x-motemen/ghq | リポジトリを `~/ghq/<host>/<owner>/<repo>` に整理して clone |
| [fzf](https://github.com/junegunn/fzf) | 0.74.5 | aqua:junegunn/fzf | あいまい検索。`Ctrl-]` のリポジトリ移動で使用 |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | 15.2.0 | aqua:BurntSushi/ripgrep | 高速 grep(`rg`) |
| [jq](https://jqlang.org/) | 1.8.2 | aqua:jqlang/jq | JSON 加工 |
| [lsd](https://github.com/lsd-rs/lsd) | 1.2.0 | aqua:lsd-rs/lsd | 色・アイコン付きの ls(`ls` で呼ぶ) |
| [bat](https://github.com/sharkdp/bat) | 0.26.1 | aqua:sharkdp/bat | ハイライト付きの cat(`cat` で呼ぶ) |
| [starship](https://starship.rs/) | 1.27.0 | aqua:starship/starship | プロンプト |
| [atuin](https://atuin.sh/) | 18.24.1 | aqua:atuinsh/atuin | 履歴検索(`Ctrl-R` と `↑`)。履歴は SQLite に保存、同期は未設定 |
| [lazygit](https://github.com/jesseduffield/lazygit) | 0.66.2 | aqua:jesseduffield/lazygit | ターミナルの git UI(`lg`) |
| [lazydocker](https://github.com/jesseduffield/lazydocker) | 0.25.2 | aqua:jesseduffield/lazydocker | ターミナルの Docker UI(`ld`)。Docker 本体は未導入 |
| [Neovim](https://neovim.io/) | 0.12.6 | aqua:neovim/neovim | エディタ。git のコミットメッセージ編集にも使う(`core.editor`) |

言語ランタイム(node / python / go など)はまだ入れていない(config.toml でコメントアウト中)。

## zsh プラグイン

定義: [`scripts/zsh-plugins.sh`](../scripts/zsh-plugins.sh)。プラグイン管理ツールは使わず、`~/.local/share/zsh/plugins/` に git clone して `.zshrc` から読み込む。

| プラグイン | 用途 |
|---|---|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | 入力中のコマンドに色を付ける |

> sheldon(Rust 製のプラグイン管理)も試したが、配布されている macOS 版が Homebrew の OpenSSL(`/opt/homebrew/opt/openssl@3`)にリンクされていて、Homebrew なしでは起動しないため不採用。

## GUI アプリ

定義: [`scripts/apps.sh`](../scripts/apps.sh)。公式配布物を取得して `/Applications` に置く。以降の更新はアプリ自身が行う。
mise は GUI アプリを扱えない(Homebrew Cask 相当の機能は Homebrew 依存)ため、この方式にしている。

| アプリ | バージョン | 取得元 | 補足 |
|---|---|---|---|
| Visual Studio Code | 1.142.0 | `update.code.visualstudio.com` の公式 zip | `code` コマンドを `~/.local/bin/code` にリンク |
| [Ghostty](https://ghostty.org/) | 1.3.1 | ghostty.org のダウンロードページに載っている公式 dmg | ターミナル |
| [AltTab](https://alt-tab-macos.netlify.app/) | 11.9.2 | GitHub Releases(lwouis/alt-tab-macos)の最新 zip | Windows 風のウィンドウ切り替え。このマシンには手動で導入済み |
| [Dia](https://www.diabrowser.com/) | — | `releases.diabrowser.com` の `Dia-latest.dmg` | ブラウザ。このマシンには手動で導入済み |

## シェル・Git の設定

| ファイル | リンク先 | 主な内容 |
|---|---|---|
| [`config/zsh/.zshrc`](../config/zsh/.zshrc) | `~/.zshrc` | `~/.local/bin` を PATH に追加、`EDITOR=nvim`、履歴(10 万件・タブ間で共有)、cd 履歴、補完(大文字小文字無視・メニュー選択)、エイリアス(`vi`/`vim`/`view`→nvim、`ls`→lsd、`cat`→bat、`lg`、`ld`)、`mise activate`、starship・atuin・プラグインの読み込み、`Ctrl-]` で ghq + fzf のリポジトリ移動 |
| [`config/zsh/.zprofile`](../config/zsh/.zprofile) | `~/.zprofile` | ログインシェルの PATH |
| [`config/git/config`](../config/git/config) | `~/.config/git/config` | エディタを nvim、`main` を既定ブランチ、`pull.rebase`、ghq の root、gh を credential helper に |
| [`config/starship/starship.toml`](../config/starship/starship.toml) | `~/.config/starship.toml` | プロンプト前の空行、Go の記号、入力位置の記号を空に(旧設定のまま) |
| [`config/git/ignore`](../config/git/ignore) | `~/.config/git/ignore` | グローバル gitignore(`.DS_Store` など) |
| `~/.config/git/config.local` | (管理対象外) | user.name / user.email などマシン固有の設定 |

## 管理していないもの

| もの | 状態 |
|---|---|
| `~/.config/karabiner/` | このマシンに既存。まだ dotfiles 管理に入れていない |
