# dotfiles

Homebrew を使わずに macOS の開発環境を作るための設定ファイル集。
CLI ツールと言語ランタイムはすべて [mise](https://mise.jdx.dev/) で管理する。

- 導入しているツールの一覧 → [docs/tools.md](docs/tools.md)
- 旧 chezmoi-dotfiles からの移行状況 → [docs/migration-from-chezmoi.md](docs/migration-from-chezmoi.md)

## 新しい Mac でのセットアップ

### 1. Xcode Command Line Tools を入れる

git を使うために必要。ダイアログが出たら「インストール」を押す(「Xcode を入手」ではない)。

```sh
xcode-select --install
```

### 2. このリポジトリを取得する

最初は ghq がまだ無いので、ghq と同じ場所に git で直接 clone する。

```sh
git clone https://github.com/ugr0/dotfiles.git ~/ghq/github.com/ugr0/dotfiles
```

### 3. インストールスクリプトを実行する

```sh
~/ghq/github.com/ugr0/dotfiles/install.sh
exec zsh -l   # シェルを再起動して設定を反映
```

`install.sh` は次の順に処理する。何度実行しても壊れない(導入済みのものはスキップ)。

| # | やること | 中身 |
|---|---|---|
| 1 | Command Line Tools の確認 | 無ければインストールを促して終了 |
| 2 | **mise のインストール** | 下記「mise の入れ方」参照 |
| 3 | 設定ファイルのリンク | `scripts/link.sh`。`~/.zshrc` などをこのリポジトリへのシンボリックリンクにする。既存の実ファイルは `*.backup.<日時>` に退避 |
| 4 | CLI ツールのインストール | `mise install`。[`config/mise/config.toml`](config/mise/config.toml) に書いたツールを入れる |
| 5 | zsh プラグインのインストール | `scripts/zsh-plugins.sh`。プラグイン管理ツールは使わず git clone する(`--update` で更新) |
| 6 | GUI アプリのインストール | `scripts/apps.sh`。VS Code・Ghostty・AltTab・Dia を公式配布物(zip / dmg)から入れる |

### 4. マシン固有の Git 設定

名前・メールはリポジトリに含めず、管理対象外の `~/.config/git/config.local` に書く。

```sh
git config --file ~/.config/git/config.local user.name  "ugr0"
git config --file ~/.config/git/config.local user.email "you@example.com"
```

### 5. GitHub にログイン

```sh
gh auth login --web --git-protocol https
```

以降の `git push` などの認証は gh が行う([`config/git/config`](config/git/config) の credential helper)。

## mise の入れ方

`install.sh` は mise 公式のインストールスクリプトを実行している。
Web サイトから手でダウンロードしたわけではなく、次の 1 行と同じことをしている。

```sh
curl https://mise.run | sh
```

- `https://mise.run` は mise 公式が案内しているインストーラ([Getting Started](https://mise.jdx.dev/getting-started.html))
- Mac 用の mise 本体(単一の実行ファイル)を公式の配布元(mise.jdx.dev / GitHub Releases)からダウンロードし、`~/.local/bin/mise` に置くだけ
- Homebrew も管理者権限も不要。アンインストールは `~/.local/bin/mise` と `~/.local/share/mise` を消せばよい
- mise 自身の更新は `mise self-update`

mise を入れた後は、[`.zshrc`](config/zsh/.zshrc) の `eval "$(mise activate zsh)"` によって、mise で入れたツールに PATH が通る。

## 日々の使い方

| やりたいこと | コマンド |
|---|---|
| CLI ツールを追加 | `mise use -g <tool>@latest`(`config/mise/config.toml` に追記される) |
| ツールを探す | `mise registry \| grep <name>` |
| ツールを更新 | `mise upgrade` |
| zsh プラグインを追加・更新 | `scripts/zsh-plugins.sh` の `PLUGINS` に追記 / `scripts/zsh-plugins.sh --update` |
| 設定ファイルを追加 | ファイルを `config/` に置き、`scripts/link.sh` に 1 行足して再実行 |
| リポジトリへ移動 | `Ctrl-]`(ghq + fzf) |

## ディレクトリ構成

```
.
├── install.sh            # セットアップの入口
├── scripts/
│   ├── link.sh           # $HOME へのシンボリックリンク作成
│   ├── zsh-plugins.sh    # zsh プラグインの取得
│   └── apps.sh           # GUI アプリのインストール
├── config/               # リンク元の設定ファイル
│   ├── zsh/              #   → ~/.zshrc, ~/.zprofile
│   ├── git/              #   → ~/.config/git/
│   ├── starship/         #   → ~/.config/starship.toml
│   └── mise/             #   → ~/.config/mise/config.toml
└── docs/                 # ドキュメント
```
