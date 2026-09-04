-- ~/.config/wezterm/adwaita_dark_theme.lua
local wezterm = require("wezterm")
return {
	foreground = "#E8EAED",
	background = "#292a2d",
	cursor_bg = "#4285F4",
	cursor_fg = "#202124",
	cursor_border = "#4285F4",
	selection_bg = "rgba(66, 133, 244, 0.3)",
	selection_fg = "none",
	split = "#292a2d",

	ansi = {
		"#202124", "#EA4335", "#34A853", "#FBBC04",
		"#4285F4", "#A142F4", "#24C1E0", "#E8EAED",
	},
	brights = {
		"#9AA0A6", "#F28B82", "#81C995", "#FDD663",
		"#8AB4F8", "#D0A1F4", "#82D9E8", "#FFFFFF",
	},

	tab_bar = {
		background = "#202124",
		active_tab = {
			bg_color = "#292a2d",
			fg_color = "#E8EAED",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#202124",
			fg_color = "#9AA0A6",
		},
		inactive_tab_hover = {
			bg_color = "#292a2d",
			fg_color = "#E8EAED",
		},
		new_tab = {
			bg_color = "#202124",
			fg_color = "#9AA0A6",
		},
		new_tab_hover = {
			bg_color = "#292a2d",
			fg_color = "#E8EAED",
		},
	},
}
