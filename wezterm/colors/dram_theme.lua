-- ~/.config/wezterm/dram_theme.lua
return {
	foreground = "#b1c9c3",
	background = "#0f3b3a",
	cursor_bg = "#b1c9c3",
	cursor_fg = "#0f3b3a",
	cursor_border = "#b1c9c3",
	selection_bg = "rgba(64, 164, 185, 0.24)",
	selection_fg = "none",
	split = "#357372",

	ansi = {
		"#0f3b3a", "#d74200", "#009403", "#e99f10",
		"#0096ff", "#b154cf", "#77bfcf", "#b1c9c3",
	},
	brights = {
		"#5c7279", "#f15f22", "#00c420", "#cfc041",
		"#40a4b9", "#da5bd6", "#77bfcf", "#e1f9f3",
	},

	tab_bar = {
		background = "#155352",
		active_tab = {
			bg_color = "#0f3b3a",
			fg_color = "#b1c9c3",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#155352",
			fg_color = "#819993",
		},
		inactive_tab_hover = {
			bg_color = "#357372",
			fg_color = "#b1c9c3",
		},
		new_tab = {
			bg_color = "#155352",
			fg_color = "#b1c9c3",
		},
		new_tab_hover = {
			bg_color = "#357372",
			fg_color = "#b1c9c3",
		},
	},
}
