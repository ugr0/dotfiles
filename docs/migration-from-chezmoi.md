# chezmoi-dotfiles からの移行

旧リポジトリ [ugr0/chezmoi-dotfiles](https://github.com/ugr0/chezmoi-dotfiles)(2023-02〜2025-07、27 コミット、69 ファイル)の中身を 1 つずつ確認し、このリポジトリに持ってくるかを決める。
手元の参照先: `~/ghq/github.com/ugr0/chezmoi-dotfiles`

## 判断の基準

- **移行**: 今も使う。パスや前提ツールを今の構成(mise・Homebrew なし)に合わせて書き直して取り込む
- **要検討**: 使うかどうかを本人が決める
- **不要**: chezmoi 専用、または Homebrew 前提・開発終了などで今の構成では使えない

「決定」列は空欄。1 つずつ確認して埋めていく。

## 一覧

chezmoi はファイル名の `dot_` を `.` に読み替えて `$HOME` に配置する(例: `dot_zshrc` → `~/.zshrc`)。

| # | ファイル | 配置先 | 内容 | 推奨 | 決定 |
|---|---|---|---|---|---|
| 1 | `dot_zshrc` | `~/.zshrc` | エイリアス、履歴設定、zinit、starship、direnv、zoxide、atuin など(146 行) | 移行(取捨選択) | 済 |
| 2 | `dot_gitconfig` | `~/.gitconfig` | 署名(GPG)、delta、diff3 など(27 行) | 移行(一部) | 済(editor のみ移行) |
| 3 | `dot_config/mise/config.toml` | `~/.config/mise/config.toml` | python, node, go, ruby, bun, deno, uv, terraform など | 移行(取捨選択) | 済(gh のみ。他は必要になったら追加) |
| 4 | `dot_Brewfile` / `.lock.json` | `~/.Brewfile` | Homebrew のパッケージ一覧(formula 80+、cask 8、VS Code 拡張 100+) | 不要(中身は参考にする) | 不要(Brewfile は使わない。GUI は Ghostty・AltTab・Dia を apps.sh に追加) |
| 5 | `dot_config/starship.toml` | `~/.config/starship.toml` | プロンプト設定(18 行) | 要検討 | 移行(そのまま) |
| 6 | `dot_config/nvim/`(archives 以外) | `~/.config/nvim/` | Neovim の設定。lazy.nvim とプラグイン 18 個 | 要検討 | 基本設定(options・keymaps)のみ移行。プラグインは必要になったら追加 |
| 7 | `dot_config/nvim/archives/` | — | 過去の Neovim 設定 2 世代分(vimscript 版、packer 版) | 不要 | 移行しない |
| 8 | `dot_config/wezterm/wezterm.lua` | `~/.config/wezterm/` | WezTerm の見た目とキー設定(61 行) | 要検討 | 移行しない(Ghostty に乗り換え。見た目・キーは Ghostty 標準) |
| 9 | `dot_hammerspoon/` | `~/.hammerspoon/` | Ctrl を 2 回押すと WezTerm を出し入れする | 要検討(#8 次第) | 移行しない(Ghostty の Quick Terminal で代替。`` Ctrl-` ``) |
| 10 | `dot_tmux.conf` / `.local` | `~/.tmux.conf` | gpakosz/.tmux(Oh my tmux!)の丸ごとコピーと上書き設定 | 要検討 | 移行しない(tmux は使わない) |
| 11 | `dot_vimrc` | `~/.vimrc` | dein.vim 時代の Vim 設定(202 行) | 不要 | 移行しない |
| 12 | `dot_ideavimrc` | `~/.ideavimrc` | JetBrains IDE の Vim 設定(`~/.vimrc` を読み込む) | 要検討 | 移行しない(JetBrains IDE 未使用) |
| 13 | `dot_config/chezmoi/chezmoi.toml` | — | chezmoi の設定 | 不要 | 移行しない |
| 14 | `.chezmoiignore` | — | chezmoi の設定 | 不要 | 移行しない |
| 15 | `.github/workflows/test.yml` | — | chezmoi で apply できるかの CI | 不要(作り直すなら別途) | 移行しない |
| 16 | `README.md` / `LICENSE` | — | chezmoi 用の説明 | 不要 | 移行しない |

## 詳細

### 1. `dot_zshrc`

| 項目 | 内容 | 推奨 | 補足 | 決定 |
|---|---|---|---|---|
| Amazon Q の pre/post ブロック | Amazon Q CLI の読み込み | 不要 | 使っていなければ削除 | 移行しない |
| `vi`/`vim`/`view` → nvim | エイリアス | #6 次第 | Neovim を使うなら移行 | 移行済み |
| `ls`→lsd、`cat`→bat、`rm`→trash-put | エイリアス | 要検討 | lsd・bat は mise で入る。trash-cli は mise に無い(macOS 標準の `trash` コマンドで代用可能か要確認) | ls・cat は移行済み。rm は移行しない |
| `ld`→lazydocker、`lg`→lazygit | エイリアス | 要検討 | どちらも mise(aqua)で入る | 移行済み |
| `cz`→chezmoi、`pstorm` | エイリアス | 不要 / 要検討 | chezmoi は使わなくなる。PhpStorm を使うなら残す | 移行しない |
| `setopt` と履歴設定 | auto_pushd、share_history、履歴 10 万件 | **移行** | そのまま使える | 移行済み |
| zinit + annex 4 つ | zsh プラグインマネージャ | 要検討 | 使っているのは fast-syntax-highlighting と atuin のみ。軽量な方法に置き換えも可 | zinit は移行しない。fast-syntax-highlighting は `scripts/zsh-plugins.sh` で導入(sheldon は Homebrew の OpenSSL 依存で不可) |
| 補完の zstyle | 大文字小文字を無視、メニュー選択 | **移行** | そのまま使える | 移行済み(`compinit` も追加) |
| `fzf-src`(`Ctrl-]`) | ghq + fzf でリポジトリ移動 | 対応済み | 新しい `.zshrc` の `ghq-cd` を `Ctrl-]` に割り当て済み | 移行済み |
| starship | プロンプト | #5 次第 | mise(aqua)で入る | 移行済み |
| PHP のパス | `/usr/local/opt/php@8.1` | 不要 | Intel 版 Homebrew のパス。PHP が必要なら mise で入れる | 移行しない |
| zig(zvm) | `~/.zvm` | 不要 | zig も必要なら mise(core:zig)で入れる | 移行しない |
| `GPG_TTY` | GPG 署名用 | #2 次第 | | 不要(署名しないため) |
| `EDITOR=nvim` | | 移行 | | 移行済み |
| direnv | | 要検討 | mise に環境変数の機能があるので不要になる可能性あり | | 移行しない(必要なら mise の `[env]`) |
| zoxide | `z` でディレクトリ移動 | 要検討 | mise(aqua)で入る | 移行しない |
| broot | `/Users/yu_takahashi/...` 固定パス | 不要 | 別マシンのユーザー名が直書きされている | 移行しない |
| `source ~/.openai_key.zsh` | API キー読み込み | 不要 | 秘密情報。dotfiles には入れない | 移行しない |
| atuin | 履歴検索 | 要検討 | zinit 版とインストーラ版の 2 重読み込みになっている。使うなら mise(aqua)の 1 つに統一 | 移行済み(mise で 1 つに統一) |

### 2. `dot_gitconfig`

現在の [`config/git/config`](../config/git/config) に足すかどうかを項目ごとに決める。

| 項目 | 推奨 | 補足 | 決定 |
|---|---|---|---|
| `user.name` / `user.email` | 対応済み | `config.local` に設定済み | 済 |
| GPG 署名(`signingKey`、`gpg.program=/opt/homebrew/bin/gpg`、`commit.gpgsign`) | 要検討 | gnupg は mise に無い。署名を続けるなら **SSH 鍵での署名**(`gpg.format=ssh`)に切り替えるのが Homebrew なしでは簡単 | 署名しない |
| `core.quotepath = false` | **移行** | 日本語ファイル名をそのまま表示する | 今回は見送り |
| `core.editor = nvim` | #6 次第 | VS Code にするなら `code --wait` | 移行(Neovim は mise で導入) |
| delta(`core.pager`、`interactive.diffFilter`、`[delta]`) | 要検討 | delta は mise(aqua)で入る | 使わない |
| AWS CodeCommit の credential helper | 不要 | 全ホストに効く設定になっている。使うなら CodeCommit のホストに限定する | 移行しない |
| `merge.conflictstyle = diff3`、`diff.colorMoved` | **移行** | そのまま使える(`zdiff3` も検討の余地あり) | 今回は見送り |

### 3. `dot_config/mise/config.toml`

| ツール | 旧指定 | 推奨 | 補足 | 決定 |
|---|---|---|---|---|
| gh | latest | 対応済み | | 移行済み |
| python | 3.11 | 要検討 | 使うなら新しいバージョンで | 見送り(必要になったら追加) |
| node | 22 | 要検討 | | 見送り(必要になったら追加) |
| go | 1.21 | 要検討 | 古い。使うなら latest | 見送り(必要になったら追加) |
| ruby | 3.3 | 要検討 | | 見送り(必要になったら追加) |
| bun / deno | latest | 要検討 | | 見送り(必要になったら追加) |
| uv | latest | 要検討 | python を使うならおすすめ | 見送り(必要になったら追加) |
| terraform | latest | 要検討 | | 見送り(必要になったら追加) |
| saml2aws | latest | 要検討 | 仕事で AWS を使うなら | 見送り(必要になったら追加) |
| serverless | 3 | 要検討 | npm 経由。v3 は古い | 見送り(必要になったら追加) |

### 4. `dot_Brewfile`

Homebrew は使わないのでファイル自体は不要。中身のうち使うものだけを mise や apps.sh に移す。

**決定(2026-10-21)**: Brewfile は使わない。CLI・VS Code 拡張は必要になったら追加する。GUI アプリは Ghostty・AltTab・Dia を `scripts/apps.sh` に追加した(cask にあった wezterm 等は見送り)。

**CLI(formula)** — mise の registry にあるか確認済み。

| mise で入る(aqua) | mise で入る(その他の backend) | mise に無い |
|---|---|---|
| act, aws-sam-cli, awscli, bat, bottom, cheat, direnv, duf, dust, fd, delta(git-delta), go-task(task), golangci-lint, gping, hyperfine, k6, lazydocker, lazygit, lsd, starship, tlrc, tmux, xh, zoxide, terraform, atuin, chezmoi | broot(github), neovim(vfox), php(vfox), clang-format(conda), java(openjdk), rust(rustup-init の代わり) | composer, gnupg, pinentry-mac, llvm, openapi-generator, procs, qemu, trash-cli, tree, trippy, saw, spotify-tui |

「mise に無い」ものも、GitHub Releases にバイナリがあれば `github:<owner>/<repo>` で入れられる場合がある。依存ライブラリだけのもの(libtiff、cairo など)と、置き換え済みのもの(rtx は mise の旧名、python@3.8 など)は対象外。

**GUI(cask)**

| アプリ | 推奨 | 補足 |
|---|---|---|
| wezterm | #8 次第 | 公式 zip があるので apps.sh で入れられる |
| orbstack | 要検討 | Docker を使うなら。公式 dmg |
| alt-tab | 要検討 | 公式 zip |
| google-japanese-ime | 要検討 | 公式 dmg(pkg) |
| android-platform-tools | 要検討 | adb など |
| ngrok | 要検討 | CLI。mise に無ければ公式配布 |
| fig | 不要 | サービス終了 |
| brewlet | 不要 | Homebrew 用のツール |

**VS Code 拡張(100 個以上)** — 一覧はそのまま残っている。使うものを選んで、拡張の一覧ファイルを作り `code --install-extension` で入れる方法か、VS Code の Settings Sync を使う方法がある。

### 6. `dot_config/nvim/`

- 構成: `init.lua`(lazy.nvim の起動)、`lua/base.lua`・`options.lua`・`keymaps.lua`、`lua/plugins/*.lua`(18 ファイル)、`lazy-lock.json`
- プラグイン: nvim-cmp、nvim-lspconfig、treesitter、telescope、nvim-tree、gitsigns、neogit、octo、lualine、barbar、noice、which-key、toggleterm、Comment、autopairs、indent-blankline、onenord(テーマ)、ChatGPT.nvim
- 注意: ChatGPT.nvim は OpenAI の API キーが必要。lspconfig の書き方は Neovim 0.11 以降で変わっているので、持ってくるなら見直しが必要
- `dot_editorconfig`、`dot_vscode/settings.json`、`stylua.toml` は nvim 設定を編集するための補助ファイル

**決定(2026-10-21)**: `options.lua` と `keymaps.lua`(barbar 用のキーを除く)だけを [`config/nvim/`](../config/nvim/) に移行。`base.lua` は `init.lua` に統合し、全 autocmd を消してしまう `autocmd!` は外した。lazy.nvim・プラグイン・補助ファイルは移行しない。

### 8. `dot_config/wezterm/wezterm.lua`

- GitHub Dark テーマ、透過 0.9、FiraCode Nerd Font 20pt、`Ctrl-B` を leader にした tmux 風のキー割り当て
- 注意: 先頭の `require 'format'` / `require 'status'` が読む `format.lua`・`status.lua` がリポジトリに無いので、**このままでは起動時にエラーになる**
- フォント(FiraCode Nerd Font)も別途入れる必要がある

### 10. `dot_tmux.conf` / `dot_tmux.conf.local`

- `dot_tmux.conf`(1534 行)は [gpakosz/.tmux](https://github.com/gpakosz/.tmux) をそのままコピーしたもの。自分で書いた設定は `.local` 側(493 行、ほとんどが元のテンプレートのまま)
- 使うなら本体はコピーせず、ghq で取ってきてリンクする方がよい
- WezTerm の分割機能と役割が重なるので、どちらを使うか決める

## 進め方

おすすめの順番(依存関係の少ないものから):

1. **#2 gitconfig**: 小さく、毎日使う
2. **#1 zshrc**: 項目ごとに選ぶ。必要なツールは同時に mise に追加する
3. **#3 mise / #4 Brewfile**: 必要な CLI とランタイムを選ぶ
4. **#8 WezTerm / #9 Hammerspoon / #10 tmux**: ターミナル環境をまとめて決める
5. **#6 Neovim / #12 ideavimrc**: エディタをまとめて決める
6. **#5 starship** ほか残り

全部の決定が埋まったら、chezmoi-dotfiles はアーカイブする。

**完了(2026-10-21)**: 全 16 項目の決定が埋まり、ugr0/chezmoi-dotfiles を GitHub 上でアーカイブした。
