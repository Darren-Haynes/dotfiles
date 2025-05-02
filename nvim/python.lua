return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	opts = {
		-- Your options go here
		-- name = "venv",
		-- auto_refresh = false
	},
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{ "<leader>ps", "<cmd>VenvSelect<cr>" },
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{ "<leader>pc", "<cmd>VenvSelectCached<cr>" },
	},
	{
		"pappasam/nvim-repl",
		opts = {
			filetype_commands = {
				javascript = { cmd = "deno repl", filetype = "javascript" },
				python = { cmd = "ipython", filetype = "python" },
			},
			default = { cmd = "bash", filetype = "bash" },
			open_window_default = "vertical split new",
		},
		keys = {
			{ "<Leader>rc", "<Plug>(ReplSendCell)", mode = "n", desc = "ReplSendCell" },
			{ "<Leader>r<leader>", "<Plug>(ReplSendLine)", mode = "n", desc = "ReplSendLine" },
			{ "<Leader>r<leader>", "<Plug>(ReplSendVisual)", mode = "x", desc = "ReplSendVisual" },
		},
	},
}
