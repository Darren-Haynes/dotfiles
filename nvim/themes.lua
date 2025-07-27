return {
	{ "sainnhe/everforest" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "everforest",
		},
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
}
