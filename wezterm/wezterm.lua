-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- 1. CRITICAL PLATFORM DETECTION (Moved to top so shortcuts can use primary_mod)
local is_mac = wezterm.target_triple:find("apple") ~= nil
local primary_mod = is_mac and "SUPER" or "CTRL"

-- DISABLE MACOS NATIVE TOP BAR (Changed from "TITLE | RESIZE" to "RESIZE")
config.window_decorations = "RESIZE"

-- 2. Color scheme natively injected
config.colors = {
	foreground = "#b1c9c3",
	background = "#0f3b3a",
	cursor_bg = "#b1c9c3",
	cursor_fg = "#0f3b3a",
	cursor_border = "#b1c9c3",
	selection_bg = "rgba(64, 164, 185, 0.24)", -- Pure CSS format bypasses hex parser issues
	selection_fg = "none",

	ansi = {
		"#0f3b3a", -- black
		"#d74200", -- red
		"#009403", -- green
		"#e99f10", -- yellow
		"#0096ff", -- blue
		"#b154cf", -- magenta
		"#77bfc3", -- cyan
		"#b1c9c3", -- white
	},
	brights = {
		"#5c7279", -- bright black
		"#f15f22", -- bright red
		"#00c420", -- bright green
		"#cfc041", -- bright yellow
		"#40a4b9", -- bright blue
		"#da5bd6", -- bright magenta
		"#77bfc3", -- bright cyan
		"#e1f9f3", -- bright white
	},

	tab_bar = {
		background = "#155352",
		active_tab = {
			bg_color = "#0f3b3a",
			fg_color = "#b1c9c3",
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
config.tab_max_width = 100 -- FIX: Prevents truncation of custom renamed tabs

-- 3. Dynamic tab formatting block mapped to Dram Palette
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index + 1
	local title = tab.active_pane.title

	if tab.tab_title and #tab.tab_title > 0 then
		title = tab.tab_title
	end

	local is_zoomed = tab.active_pane.is_zoomed
	local formatted_text = string.format(" %d: %s ", index, title)

	local bg_color = "#155352" -- Inactive tab background
	local fg_color = "#819993" -- Inactive muted text

	if tab.is_active then
		if is_zoomed then
			bg_color = "#00c420" -- Dram Bright Green accent block for zoom visibility
			fg_color = "#0f3b3a" -- Dark active background text
			formatted_text = string.format(" 🔍 %d: %s [ZOOMED] ", index, title)
		else
			bg_color = "#0f3b3a" -- Active tab background
			fg_color = "#b1c9c3" -- Active foreground text
		end
	elseif hover then
		bg_color = "#357372" -- Hover element background
		fg_color = "#b1c9c3" -- Active text contrast
	end

	return {
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Text = formatted_text },
	}
end)

-- 4. Move focus or split window shortcut helper
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
