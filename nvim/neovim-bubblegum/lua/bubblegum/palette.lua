-- Bubblegum palette for Neovim.
-- Dark values come from zed/themes/bubblegum/bubblegum+.json; light values
-- follow the "Bubblegum Light" GTK / dunst colours (#f5f5f5 bg, #b060a0 pink,
-- #0088cc blue) with syntax colours darkened for contrast.
local M = {}

M.dark = {
  bg = "#303030",
  bg_dark = "#2a2a2a", -- statusline, floats, panels
  bg_alt = "#3a3a3a", -- cursorline, colorcolumn
  bg_float = "#252525",
  bg_visual = "#454545",
  bg_search = "#4f3f30",
  border = "#454545",
  guide = "#454545",
  fg = "#d7d7d7",
  text = "#a7a7a7", -- default editor text
  fg_dim = "#a7a7a7",
  fg_variable = "#afafaf",
  comment = "#808080",
  line_nr = "#808080",
  line_nr_active = "#e2e2e2",
  punct = "#878787",

  pink = "#d7afd7", -- signature accent (functions)
  blue = "#87afd7", -- keywords, operators
  cyan = "#87d7ff", -- cursor / UI accent
  purple = "#afafd7", -- types
  green = "#afd787", -- preproc, attributes, added
  string = "#d7d7a7",
  constant = "#d7d787",
  number = "#d7af5f",
  red = "#d78787",
  orange = "#d7af87",
  teal = "#7fc5c5",

  diff_add = "#2a3a2a",
  diff_delete = "#402020",
  diff_change = "#3a3a2a",
  diff_text = "#4a4a2a",
  error_bg = "#402020",
  warn_bg = "#4f3f30",
}

M.light = {
  bg = "#f5f5f5",
  bg_dark = "#e0e0e0",
  bg_alt = "#ececec",
  bg_float = "#ececec",
  bg_visual = "#d5d5d5",
  bg_search = "#f0dcb5",
  border = "#c8c8c8",
  guide = "#d5d5d5",
  fg = "#2a2a2a",
  text = "#2a2a2a",
  fg_dim = "#666666",
  fg_variable = "#4a4a4a",
  comment = "#888888",
  line_nr = "#999999",
  line_nr_active = "#2a2a2a",
  punct = "#707070",

  pink = "#b060a0",
  blue = "#006ca8",
  cyan = "#0088cc",
  purple = "#5f5fa0",
  green = "#4f7f2f",
  string = "#75702a",
  constant = "#7a7a00",
  number = "#a66a00",
  red = "#c0504d",
  orange = "#b07a30",
  teal = "#2a8a8a",

  diff_add = "#dcefd0",
  diff_delete = "#f3d4d4",
  diff_change = "#f0ebc8",
  diff_text = "#e6dfa0",
  error_bg = "#f3d4d4",
  warn_bg = "#f3e3c4",
}

return M
