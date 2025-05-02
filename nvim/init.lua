-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
--  _   _         _               ____                __  _
-- | \ | |__   __(_) _ __ ___    / ___| ___   _ __   / _|(_)  __ _
-- |  \| |\ \ / /| || '_ ` _ \  | |    / _ \ | '_ \ | |_ | | / _` |
-- | |\  | \ V / | || | | | | | | |___| (_) || | | ||  _|| || (_| |
-- |_| \_|  \_/  |_||_| |_| |_|  \____|\___/ |_| |_||_|  |_| \__, |
--                                                           |___/

-- python3 virtenv
--vim.g.loaded_python3_provider = 1
-- vim.g.python3_host_prog = "/home/darren/.pyenv/versions/nvim-3.13.venv/bin/python"

-- Windows 11
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = "silent !zellij action switch-mode normal",
})
