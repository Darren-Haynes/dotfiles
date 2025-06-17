return {
	{ "ribru17/bamboo.nvim" },
	{ "Everblush/nvim", name = "everblush" },
	{ "ramojus/mellifluous.nvim" },
	{
		"uloco/bluloco.nvim",
		lazy = false,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{ "catppuccin/nvim" },
}
