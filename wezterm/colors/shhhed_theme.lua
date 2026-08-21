local wezterm = require("wezterm")

return {
  -- Base Colors
  foreground = "#d4d4d4", -- Assumed light gray (not explicitly provided)
  background = "#1e1e22",

  -- Cursor Colors
  cursor_bg = "#60b1b1", -- Using 'Types' color
  cursor_fg = "#1e1e22",
  cursor_border = "#60b1b1",

  -- Selection Colors
  selection_fg = "#1e1e22",
  selection_bg = "#729bcf", -- Using 'Functions' color

  -- Split Line Color
  split = "#918699", -- Using 'Keywords' color

  -- ANSI Colors (0-7)
  ansi = {
    "#1e1e22", -- Black (Background)
    "#ca8489", -- Red (Numbers)
    "#60b1b1", -- Green (Types)
    "#c48d2f", -- Yellow (Strings)
    "#729bcf", -- Blue (Functions)
    "#918699", -- Magenta (Keywords)
    "#60b1b1", -- Cyan (Types, reused)
    "#d4d4d4", -- White (Foreground, assumed)
  },

  -- Bright ANSI Colors (8-15)
  brights = {
    "#2e2e32", -- Bright Black
    "#e0a0a0", -- Bright Red
    "#80d0d0", -- Bright Green
    "#e0a040", -- Bright Yellow
    "#90b0e0", -- Bright Blue
    "#a090b0", -- Bright Magenta
    "#80d0d0", -- Bright Cyan
    "#ffffff", -- Bright White
  },

  -- Tab Bar Configuration
  tab_bar = {
    background = "#1e1e22",
    active_tab = {
      bg_color = "#729bcf", -- Functions
      fg_color = "#1e1e22",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#2e2e32",
      fg_color = "#918699", -- Keywords
    },
    inactive_tab_hover = {
      bg_color = "#3e3e42",
      fg_color = "#60b1b1", -- Types
    },
    new_tab = {
      bg_color = "#1e1e22",
      fg_color = "#918699",
    },
    new_tab_hover = {
      bg_color = "#3e3e42",
      fg_color = "#60b1b1",
    },
  },
}
