-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- CRITICAL PLATFORM DETECTION (Moved to top so shortcuts can use primary_mod)
local is_mac = wezterm.target_triple:find("apple") ~= nil
local primary_mod = is_mac and "SUPER" or "CTRL"

-- Set inital height and width of wezterm (iMac maximum)
config.initial_cols = 2240
config.initial_rows = 1260

-- DISABLE MACOS NATIVE TOP BAR (Changed from "TITLE | RESIZE" to "RESIZE")
config.window_decorations = "RESIZE"

-- Open wezterm maximized (but not fullscreen)
local has_maximized = false
wezterm.on("window-focus-changed", function(window, pane)
	if window and not has_maximized then
		window:maximize()
		has_maximized = true -- Prevent infinite loops
	end
end)

-- PERSISTENT MUX SESSIONS
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
wezterm.on("gui-startup", function(cmd)
	-- Fire the native startup resurrection script instantly
	resurrect.state_manager.resurrect_on_gui_startup(cmd)

	-- Safely kick off the periodic save loop background thread
	resurrect.state_manager.periodic_save({
		interval_seconds = 300, -- 5 minutes
		save_workspaces = true,
		save_windows = true,
		save_tabs = true,
	})
end)

-- -- Optional but Highly Recommended UI Flattening Additions:
config.inactive_pane_hsb = {
	saturation = 0.93, -- Slightly desaturate inactive text
	brightness = 0.85, -- Dim the background and foreground down to 70%
}

config.window_frame = {
	active_titlebar_bg = "#155352",
	inactive_titlebar_bg = "#155352",
}

-- Fonts
config.font = wezterm.font("Fira Code")
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

-- Padding configuration
config.window_padding = {
	left = "30px",
	right = "30px",
	top = "10px",
	bottom = "0px",
}

-- -- Tab bar layout settings
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.enable_tab_bar = true
config.tab_max_width = 100

-- Apply colors to config
-- local active_theme_name = 'colors.dram_theme'
-- local active_theme_name = 'colors.solarized_dark'
-- config.colors = require(active_theme_name)
config.color_scheme = 'Ayu Mirage'
local active_theme_name = 'Ayu Mirage'
config.colors = wezterm.color.get_builtin_schemes()[active_theme_name]

-- 3. Helper to get theme colors inside callbacks
local function get_theme_colors()
    -- Re-require the module to get fresh data (Lua caches require, but this ensures we use the variable)
    return require(active_theme_name)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    -- 1. Get colors directly from the required module using the global variable
    local theme = require(active_theme_name)
    local t = theme.tab_bar
    local index = tab.tab_index + 1
    local title = nil

    if tab.tab_title and #tab.tab_title > 0 then
        title = tab.tab_title

    elseif tab.active_pane.title and #tab.active_pane.title > 0 then
        title = tab.active_pane.title
    end

    if not title or #title == 0 then
        title = "Shell"
    end

    local is_zoomed = tab.active_pane.is_zoomed
    local formatted_text = string.format(" (%d) ---%s--- ", index, title)
    local bg_color = t.inactive_tab.bg_color
    local fg_color = t.inactive_tab.fg_color

    if tab.is_active then
        if is_zoomed then
            bg_color = t.active_tab.bg_color
            fg_color = t.active_tab.fg_color
            formatted_text = string.format(" 🔍 (%d): %s [ZOOMED] ", index, title)
        else
            bg_color = t.active_tab.bg_color
            fg_color = t.active_tab.fg_color
        end
    elseif hover then
        bg_color = t.inactive_tab_hover.bg_color
        fg_color = t.inactive_tab_hover.fg_color
    end

    return {
        { Background = { Color = bg_color } },
        { Foreground = { Color = fg_color } },
        { Text = formatted_text },
    }
end)

local function is_vim(pane)
	local user_vars = pane:get_user_vars()
	if user_vars.IS_NVIM == "true" then
		return true
	end

	local process_info = pane:get_foreground_process_info()
	if not process_info then
		return false
	end

	if process_info.name == "nvim" or process_info.name == "vim" then
		return true
	end

	if process_info.args then
		for _, arg in ipairs(process_info.args) do
			if arg:match("nvim") or arg:match("vim") then
				return true
			end
		end
	end
	return false
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- multiplexer
-- config.unix_domains = {
-- 	{
-- 		name = "HOME",
-- 		no_serve_automatically = false,
-- 	},
-- }

-- Connect to the multiplexer on startup
-- config.default_gui_startup_args = { "connect", "HOME" }

-- LEADER KEY
config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = 1000
}

config.keys = { -- Clear out default OS hotkey assignments
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

	-- Move between panes -- Resize panes (Meta/Alt + hjkl)
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	-- Navigate tabs left/right
	{ key = "H", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	-- Split panes
    { key = 'h', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Left', size = { Percent = 25 }, }, },
    { key = 'j', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Down', size = { Percent = 25 }, }, },
    { key = 'k', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Up', size = { Percent = 25 }, }, },
    { key = 'l', mods = 'LEADER', action = wezterm.action.SplitPane { direction = 'Right', size = { Percent = 25 }, }, },

    -- OPTIONAL: Double-tap Ctrl-A to send Ctrl-A to applications (like bash/tmux)
    {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },

	-- Resize split layouts
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

	-- Reload WezTerm config with Leader + r
    { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration, },

	-- Zoom toggle mapping (Cleaned Lua Syntax)
	{
		key = "Escape",
		mods = "SHIFT",
		action = wezterm.action_callback(function(window, pane)
			-- 1. Fire the actual pane zoom command natively
			window:perform_action(wezterm.action.TogglePaneZoomState, pane)

			-- 2. Fetch the active configuration overrides layer
			local overrides = window:get_config_overrides() or {}

			-- 3. Toggle the tab bar based explicitly on its CURRENT override status
			if overrides.enable_tab_bar == nil or overrides.enable_tab_bar == true then
				overrides.enable_tab_bar = false
			else
				overrides.enable_tab_bar = true
			end

			-- 4. Instantly load the override state to hide/show the bar
			window:set_config_overrides(overrides)
		end),
	},

	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- and allow activating one.
	{ key = "o", mods = "SUPER|ALT", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	-- Switch to the default workspace
	{
		key = "y",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SwitchToWorkspace({
			name = "default",
		}),
	},
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "W",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},

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
