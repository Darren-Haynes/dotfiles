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

  pink = "#d7afd7", -- signature accent (UI)
  func = "#d7afd7", -- functions
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
  func = "#b060a0",
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

-- "shhhed" family, derived from zed/themes/shhhed/shhhed.json. `pink` holds the
-- sage-green UI accent; `func` is the theme's blue function colour.
M.shhhed_dark = {
  bg = "#1e1e22", -- editor.background
  bg_dark = "#17171a",
  bg_alt = "#232328",
  bg_float = "#26262b",
  bg_visual = "#38383d",
  bg_search = "#415048",
  border = "#2a2a2f",
  guide = "#27272c",
  fg = "#dadadf",
  text = "#cbcbcf",
  fg_dim = "#85858b",
  fg_variable = "#b8b8bc",
  comment = "#797981",
  line_nr = "#4d4d52",
  line_nr_active = "#9e9ea4",
  punct = "#74747a",

  pink = "#6ca880",
  func = "#729bcf",
  blue = "#918699",
  cyan = "#8bc37b",
  purple = "#60b1b1",
  green = "#7f8e7f",
  string = "#c48d2f",
  constant = "#c09090",
  number = "#ca8489",
  red = "#cc7078",
  orange = "#c8a050",
  teal = "#6088b0",

  diff_add = "#2e3a35",
  diff_delete = "#3b2f32",
  diff_change = "#393329",
  diff_text = "#4e422f",
  error_bg = "#412e33",
  warn_bg = "#3d352a",
}

M.shhhed_light = {
  bg = "#fbfdff", -- editor.background
  bg_dark = "#eaf1f7",
  bg_alt = "#f4f8fc",
  bg_float = "#f1f6fb",
  bg_visual = "#d7e1eb",
  bg_search = "#c7dcd1",
  border = "#e1eaf3",
  guide = "#e4edf6",
  fg = "#1e1a14",
  text = "#1e1a14",
  fg_dim = "#797983",
  fg_variable = "#2d2821",
  comment = "#877f73",
  line_nr = "#a4a4ab",
  line_nr_active = "#62626a",
  punct = "#7f7970",

  pink = "#2a7848",
  func = "#0050d8",
  blue = "#79658d",
  cyan = "#1e6838",
  purple = "#008cb4",
  green = "#547559",
  string = "#a85b01",
  constant = "#c42840",
  number = "#c82868",
  red = "#b84e60",
  orange = "#9c7c00",
  teal = "#236292",

  diff_add = "#deeae5",
  diff_delete = "#ece3e6",
  diff_change = "#eeebdb",
  diff_text = "#e2dbbd",
  error_bg = "#f2e4e9",
  warn_bg = "#ece8d6",
}

return M
