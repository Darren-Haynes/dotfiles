-- =====================================================================
-- INITIALIZE
-- =====================================================================
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Wezterm session management
local act = wezterm.action
local sessions = wezterm.plugin.require(
  "https://github.com/abidibo/wezterm-sessions"
)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- =====================================================================
-- GLOBAL THEME ENGINE SETUP
-- =====================================================================
-- config.color_scheme = 'Ayu Mirage'
-- local active_theme_name = 'Ayu Mirage'
config.color_scheme = 'BlulocoDark'
local active_theme_name = 'BlulocoDark'
-- config.color_scheme = 'Solarized Dark (Gogh)'
-- local active_theme_name = 'Solarized Dark (Gogh)'


-- =====================================================================
-- PRE-CALCULATE THEME COLORS (Run ONCE at startup)
-- =====================================================================
local all_schemes = wezterm.color.get_builtin_schemes()
local current_theme = all_schemes[active_theme_name] or {}

-- Ayu Mirage Ansi colors
local ansi_green = (current_theme.ansi and current_theme.ansi[3]) or "#9CCD62"
local ansi_white = (current_theme.ansi and current_theme.ansi[0]) or "#C7C7C7"

-- Extract colors safely with fallbacks
local theme_bg = current_theme.background or "#1a1a1a"
local theme_fg = current_theme.foreground or "#ffffff"
local theme_cursor = current_theme.cursor_bg or "#ffcc66"

-- Extract Tab Bar specific colors if they exist, otherwise fallback to theme colors
local tab_colors = current_theme.tab_bar or {}
local inactive_tab_bg = (tab_colors.inactive_tab and tab_colors.inactive_tab.bg_color) or theme_bg
local inactive_tab_fg = (tab_colors.inactive_tab and tab_colors.inactive_tab.fg_color) or theme_fg
local active_tab_bg = (tab_colors.active_tab and tab_colors.active_tab.bg_color) or theme_cursor
local active_tab_fg = (tab_colors.active_tab and tab_colors.active_tab.fg_color) or theme_bg
local hover_tab_bg = (tab_colors.inactive_tab_hover and tab_colors.inactive_tab_hover.bg_color) or theme_fg
local hover_tab_fg = (tab_colors.inactive_tab_hover and tab_colors.inactive_tab_hover.fg_color) or theme_bg

-- Extract active theme definition properties dynamically from WezTerm
local current_theme_table = wezterm.color.get_builtin_schemes()[active_theme_name]
local dynamic_bg = (current_theme_table and current_theme_table.background) or "#1a1a1a"

-- Pre-calculate colors for the Status Bar
local status_bg = theme_bg
local status_fg = theme_fg
local status_accent = theme_cursor

-- Initialize base configuration colors
config.colors = current_theme_table or {}

-- Dynamic Window Frame: Adapts empty tab space matching the theme background color
config.window_frame = {
	active_titlebar_bg = dynamic_bg,
	inactive_titlebar_bg = dynamic_bg,
	active_titlebar_border_bottom = dynamic_bg,
	inactive_titlebar_border_bottom = dynamic_bg,
}

-- Fills retro/flat empty padding blocks in the tab bar safely
config.colors.tab_bar = {
    background = dynamic_bg,
}

-- =====================================================================
-- PLATFORM & DISPLAY LAYOUT
-- =====================================================================
local is_mac = wezterm.target_triple:find("apple") ~= nil
local primary_mod = is_mac and "SUPER" or "CTRL"

-- Set initial height and width of wezterm (iMac maximum)
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

-- =====================================================================
-- TYPOGRAPHY & INTERFACE PADDING
-- =====================================================================
config.font = wezterm.font("Fira Code")
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
	left = "30px",
	right = "30px",
	top = "10px",
	bottom = "0px",
}

-- =====================================================================
-- TAB BAR INTERFACE SWITCHES
-- =====================================================================
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.enable_tab_bar = true
config.tab_max_width = 100
config.show_new_tab_button_in_tab_bar = false

-- =====================================================================
-- DYNAMIC TAB FORMATTING RENDER ENGINE
-- =====================================================================
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    -- Use the pre-calculated global variables defined above
    local bg_color = inactive_tab_bg
    local fg_color = inactive_tab_fg

    local index = tab.tab_index + 1
    local title = tab.tab_title and #tab.tab_title > 0 and tab.tab_title or (tab.active_pane.title and #tab.active_pane.title > 0 and tab.active_pane.title or "Shell")

    local is_zoomed = tab.active_pane.is_zoomed
    local formatted_text = string.format(" (%d) ---%s--- ", index, title)

    if tab.is_active then
        bg_color = ansi_white
        fg_color = active_tab_fg
        if is_zoomed then
            formatted_text = string.format(" 🔍 (%d): %s [ZOOMED] ", index, title)
        end
    elseif hover then
        bg_color = hover_tab_bg
        fg_color = hover_tab_fg
    end

    return {
        { Background = { Color = bg_color } },
        { Foreground = { Color = fg_color } },
        { Text = formatted_text },
    }
end)
-- REPLACE YOUR ENTIRE is_vim FUNCTION WITH THIS:
local function is_vim(pane)
    -- ONLY check user vars. This is instantaneous (0ms overhead).
    local user_vars = pane:get_user_vars()
    return user_vars.IS_NVIM == "true"
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

-- =====================================================================
-- DYNAMIC RIGHT STATUS AREA (Workspace & Clock Engine)
-- =====================================================================
wezterm.on("update-status", function(window, pane)
    -- Use pre-calculated global variables (Zero overhead)
    local primary_bg = status_bg
    local primary_fg = status_fg
    local accent_color = status_accent

    -- 2. Fetch the current active workspace name
    local current_workspace = window:active_workspace()

    -- 3. Format the date/time string
    local time_string = wezterm.strftime(" %b %d • %H:%M ")

    -- 4. Render the full styled layout
    window:set_right_status(wezterm.format({
        -- WORKSPACE SEGMENT
        { Background = { Color = primary_bg } },
        { Foreground = { Color = accent_color } },

        { Background = { Color = primary_bg } },
        { Foreground = { Color = ansi_green } },
        { Attribute  = { Intensity = "Bold" } },
        { Text = "<" .. current_workspace .. "/>" },

        -- Visual Separator
        { Background = { Color = primary_bg } },
        { Foreground = { Color = primary_fg } },
        { Attribute  = { Intensity = "Half" } },
        { Text = " │" }, -- Added a visible separator character

        -- CLOCK SEGMENT
        { Background = { Color = primary_bg } },
        { Foreground = { Color = accent_color } },
        { Attribute  = { Intensity = "Normal" } },
        { Text = time_string },
    }))
end)

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

	-- Resize split layouts
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

	-- Reload WezTerm config with Leader + r
    { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration, },

	-- Zoom toggle mapping
	{
		key = "Escape",
		mods = "SHIFT",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(wezterm.action.TogglePaneZoomState, pane)
			local overrides = window:get_config_overrides() or {}
			if overrides.enable_tab_bar == nil or overrides.enable_tab_bar == true then
				overrides.enable_tab_bar = false
			else
				overrides.enable_tab_bar = true
			end
			window:set_config_overrides(overrides)
		end),
	},

	-- Show the launcher in fuzzy selection mode
	{ key = "o", mods = "SUPER|ALT", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	-- Switch to the default workspace
	{
		key = "y",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SwitchToWorkspace({
			name = "default",
		}),
	},

	-- Prompt for a name to use for a new workspace and switch to it
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
				if line and #line > 0 then
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
		key = "r",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab:",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
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

-- Optional: adds default keybindings and plugin configuration
sessions.apply_to_config(config, {
  -- Auto-save interval in seconds (default: 30)
  auto_save_interval_s = 30,
  -- Warn when git branches changed on restore (default: true)
  git_branch_warn = true,
})
-- return wezterm config just in case that wasn't clear
return config
