-- ~/.config/wezterm/colors/solarized_dark.lua
return {
  -- Core Colors mapped from Zed theme
  foreground = "#839496",          -- editor.foreground
  background = "#002b36",          -- editor.background
  cursor_bg = "#839496",           -- Matching foreground for visibility
  cursor_fg = "#002b36",           -- Matching background
  cursor_border = "#839496",

  -- Selection uses the accent color with transparency logic similar to Zed's element.selected
  selection_bg = "rgba(38, 139, 210, 0.4)",
  selection_fg = "#839496",

  -- Split border uses the focused border color
  split = "#268bd2",

  -- Solarized Standard ANSI Palette
  ansi = {
    "#002b36", -- black (background)
    "#dc322f", -- red (conflict/error)
    "#859900", -- green (created)
    "#b58900", -- yellow (modified)
    "#268bd2", -- blue (accents/info)
    "#d33682", -- magenta (Standard Solarized Magenta, not explicitly in Zed snippet but required for palette)
    "#2aa198", -- cyan (Standard Solarized Cyan, not explicitly in Zed snippet but required for palette)
    "#839496", -- white (foreground)
  },
  brights = {
    "#073642", -- bright black (panel.background / drop_target)
    "#cb4b16", -- bright red (deleted)
    "#586e75", -- bright green (border / line_number)
    "#657b83", -- bright yellow (Standard Solarized bright yellow)
    "#839496", -- bright blue (foreground / active_line_number)
    "#6c71c4", -- bright magenta (Standard Solarized bright magenta)
    "#93a1a1", -- bright cyan (panel.indent_guide_hover)
    "#fdf6e3", -- bright white (Standard Solarized light background, used for high contrast)
  },

  -- Tab Bar Configuration mapped from Zed Panel/Element colors
  tab_bar = {
    background = "#073642",        -- panel.background
    active_tab = {
      bg_color = "#002b36",        -- editor.background (active editor feel)
      fg_color = "#839496",        -- editor.foreground
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#073642",        -- panel.background
      fg_color = "#586e75",        -- border / muted icon
    },
    inactive_tab_hover = {
      bg_color = "#002b36",        -- Elevate to editor background on hover
      fg_color = "#839496",
    },
    new_tab = {
      bg_color = "#073642",
      fg_color = "#586e75",
    },
    new_tab_hover = {
      bg_color = "#268bd2",        -- Accent color
      fg_color = "#002b36",        -- Dark text on bright accent
    },
  },
}
