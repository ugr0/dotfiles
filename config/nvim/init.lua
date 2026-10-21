-- Neovim config: basic options and keymaps only (no plugins yet).
-- Migrated from chezmoi-dotfiles (base.lua / options.lua / keymaps.lua).

vim.scriptencoding = "utf-8"
vim.g.mapleader = "\\"

require("options")
require("keymaps")
