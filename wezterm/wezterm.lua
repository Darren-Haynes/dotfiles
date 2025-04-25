-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color scheme
config.color_scheme = "Tokyo Night"
config.window_background_image = "../wezterm/ShakyamuniBuddhaTerminalBackground.jpg"

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.03,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}
-- Fonts
config.font_size = 11.0
config.adjust_window_size_when_changing_font_size = false

-- No padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
-- and finally, return the configuration to wezterm
return config
