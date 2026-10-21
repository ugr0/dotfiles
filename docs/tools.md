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
| [fzf](https://github.com/junegunn/fzf) | 0.74.5 | aqua:junegunn/fzf | あいまい検索。`Ctrl-G` のリポジトリ移動で使用 |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | 15.2.0 | aqua:BurntSushi/ripgrep | 高速 grep(`rg`) |
| [jq](https://jqlang.org/) | 1.8.2 | aqua:jqlang/jq | JSON 加工 |

言語ランタイム(node / python / go など)はまだ入れていない(config.toml でコメントアウト中)。

## GUI アプリ

定義: [`scripts/apps.sh`](../scripts/apps.sh)。公式配布物を取得して `/Applications` に置く。以降の更新はアプリ自身が行う。

| アプリ | バージョン | 取得元 | 補足 |
|---|---|---|---|
| Visual Studio Code | 1.142.0 | `update.code.visualstudio.com` の公式 zip | `code` コマンドを `~/.local/bin/code` にリンク |

## シェル・Git の設定

| ファイル | リンク先 | 主な内容 |
|---|---|---|
| [`config/zsh/.zshrc`](../config/zsh/.zshrc) | `~/.zshrc` | `~/.local/bin` を PATH に追加、`mise activate`、`Ctrl-G` で ghq + fzf のリポジトリ移動 |
| [`config/zsh/.zprofile`](../config/zsh/.zprofile) | `~/.zprofile` | ログインシェルの PATH |
| [`config/git/config`](../config/git/config) | `~/.config/git/config` | `main` を既定ブランチ、`pull.rebase`、ghq の root、gh を credential helper に |
| [`config/git/ignore`](../config/git/ignore) | `~/.config/git/ignore` | グローバル gitignore(`.DS_Store` など) |
| `~/.config/git/config.local` | (管理対象外) | user.name / user.email などマシン固有の設定 |

## 管理していないもの

| もの | 状態 |
|---|---|
| `~/.config/karabiner/` | このマシンに既存。まだ dotfiles 管理に入れていない |
