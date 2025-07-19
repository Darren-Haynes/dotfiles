return {
	{ "sainnhe/everforest" },

	-- Configure LazyVim to load everforest
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "everforest",
		},
	},
	{ "gbprod/nord.nvim", lazy = false, priority = 1000 },
}
