-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_decorations = "TITLE | RESIZE"

-- Color scheme
config.color_scheme = "OneDark (base16)"
-- config.window_background_image = "/Users/darren/.config/wezterm/ShakyamuniBuddhaTerminalBackground.jpg"

-- config.window_background_image_hsb settings
config.window_background_image_hsb = {
	brightness = 0.20,
	hue = 1.0,
	saturation = 1.0,
}

-- Fonts
config.font = wezterm.font("Fira Code")
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

-- Padding configuration
config.window_padding = {
	left = "35px",
	right = "35px",
	top = "0px",
	bottom = "25px",
}

-- Tab bar layout settings
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.enable_tab_bar = true

-- 1. Unify the window frame container background to eliminate hidden layers
config.window_frame = {
	active_titlebar_bg = "none",
	inactive_titlebar_bg = "none",
}

-- 2. Clear out the global tab tracking margins
config.colors = {
	tab_bar = {
		background = "none",
		active_tab = { bg_color = "none", fg_color = "none" },
		inactive_tab = { bg_color = "none", fg_color = "none" },
		inactive_tab_hover = { bg_color = "none", fg_color = "none" },
		new_tab = { bg_color = "none", fg_color = "none" },
		new_tab_hover = { bg_color = "none", fg_color = "none" },
	},
	-- Toggle maximize pane
	{
        key = 'Escape',
        mods = 'SHIFT',
        action = wezterm.action.TogglePaneZoomState,
    }
}

config.tab_max_width = 999

-- 3. Format tab titles dynamically and show bright orange contrast when zoomed
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index + 1
	local title = tab.active_pane.title

	if tab.tab_title and #tab.tab_title > 0 then
		title = tab.tab_title
	end

	local is_zoomed = tab.active_pane.is_zoomed
	local formatted_text = string.format(" %d: %s ", index, title)

	local bg_color = "none"
	local fg_color = "#5c6370"

	if tab.is_active then
		if is_zoomed then
			bg_color = "#d19a66" -- OneDark Orange accent block
			fg_color = "#282c34"
			formatted_text = string.format(" 🔍 %d: %s [ZOOMED] ", index, title)
		else
			bg_color = "#3e4452" -- Standard active bubble
			fg_color = "#abb2bf"
		end
	elseif hover then
		bg_color = "#2c313c"
		fg_color = "#abb2bf"
	end

	return {
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Text = formatted_text },
	}
end)

-- 4. Dynamic cross-platform detection variables
local is_mac = wezterm.target_triple:find("apple") ~= nil
local primary_mod = is_mac and "SUPER" or "CTRL"

-- 5. Move focus or split window shortcut helper
local function move_or_split(direction)
	return wezterm.action_callback(function(window, pane)
		window:perform_action(wezterm.action.ActivatePaneDirection(direction), pane)
		local current_pane = window:active_pane()
		if current_pane:pane_id() == pane:pane_id() then
			window:perform_action(wezterm.action.SplitPane({ direction = direction }), pane)
		end
	end)
end

config.keys = {
	-- Clear out default OS hotkey assignments
	{ key = "m", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "n", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "v", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "c", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "t", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "o", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "w", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "1", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "2", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "3", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "4", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "5", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "6", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "7", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "8", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "9", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "r", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "h", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "k", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },
	{ key = "f", mods = "SUPER", action = wezterm.action.DisableDefaultAssignment },

	-- Cross-platform Copy & Paste
	{ key = "c", mods = primary_mod, action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = primary_mod, action = wezterm.action.PasteFrom("Clipboard") },

	-- Vim pane navigation / smart creation shortcuts
	{ key = "h", mods = "CTRL", action = move_or_split("Left") },
	{ key = "j", mods = "CTRL", action = move_or_split("Down") },
	{ key = "k", mods = "CTRL", action = move_or_split("Up") },
	{ key = "l", mods = "CTRL", action = move_or_split("Right") },

	-- Navigate tabs left/right
	{ key = "H", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	-- Resize split layouts
	{ key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow",    mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

	-- Zoom toggle mapping
	{ key = "Escape", mods = "SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Dynamic tab renaming prompt
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

-- Inject Ctrl/Cmd + Number shortcuts dynamically for jumping to Tabs 1-9
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = primary_mod,
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
