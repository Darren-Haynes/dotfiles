-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Escape terminal
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
-- Escape insert mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
