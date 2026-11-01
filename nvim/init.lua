-- Minimal Neovim config: Bubblegum colorscheme that follows the desktop
-- light/dark setting (sway/toggle-theme.sh).
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/neovim-bubblegum")

vim.o.termguicolors = true
vim.o.background = "dark" -- until sync_with_system() reports the real value
vim.cmd.colorscheme("bubblegum")
require("bubblegum").sync_with_system()
