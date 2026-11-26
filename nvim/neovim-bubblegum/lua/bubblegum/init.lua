local M = {}

local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

local terminal = {
  dark = { "#303030", "#d78787", "#afd787", "#d7d787", "#87afd7", "#d7afd7", "#87d7ff", "#d7d7d7",
    "#808080", "#ff5555", "#55ff55", "#ffff55", "#5555ff", "#ff55ff", "#55ffff", "#ffffff" },
  light = { "#2a2a2a", "#c0504d", "#4f7f2f", "#75702a", "#006ca8", "#b060a0", "#0088cc", "#d5d5d5",
    "#666666", "#cc3333", "#5f8f3f", "#8a8230", "#0088cc", "#c070b0", "#2a8a8a", "#f5f5f5" },
  shhhed_dark = { "#27272c", "#c97279", "#7db277", "#c8a050", "#729bcf", "#a088ac", "#60b1b1", "#c8c8cc",
    "#49494e", "#e08088", "#88c880", "#d8b068", "#90bce0", "#b898d8", "#80d0cc", "#dadadf" },
  shhhed_light = { "#1e1a14", "#b84e60", "#2a7848", "#9c7c00", "#0050d8", "#604f73", "#006c83", "#6e685f",
    "#797983", "#c06068", "#3a8a55", "#b69000", "#2868e0", "#855290", "#007783", "#645c50" },
}

--- Active theme family: "bubblegum" (default) or "shhhed", read from the state
--- file written by the theme toggle.
function M.read_family()
  local f = io.open(vim.fn.expand("~/.local/state/bubblegum/family"), "r")
  if not f then
    return "bubblegum"
  end
  local line = f:read("*l")
  f:close()
  line = vim.trim(line or "")
  return line == "shhhed" and "shhhed" or "bubblegum"
end

function M.load()
  local variant = vim.o.background == "light" and "light" or "dark"
  local family = M.read_family()
  local key = family == "shhhed" and ("shhhed_" .. variant) or variant
  local p = require("bubblegum.palette")[key]
  vim.g.bubblegum_family = family

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "bubblegum"
  vim.o.termguicolors = true

  -- Terminal palette
  for i, c in ipairs(terminal[key]) do
    vim.g["terminal_color_" .. (i - 1)] = c
  end

  local groups = {
    -- Editor UI
    Normal = { fg = p.text, bg = p.bg },
    NormalNC = { link = "Normal" },
    NormalFloat = { fg = p.fg, bg = p.bg_float },
    FloatBorder = { fg = p.pink, bg = p.bg_float },
    FloatTitle = { fg = p.pink, bg = p.bg_float, bold = true },
    Cursor = { fg = p.bg, bg = p.cyan },
    lCursor = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = p.bg_alt },
    CursorColumn = { bg = p.bg_alt },
    ColorColumn = { bg = p.bg_alt },
    CursorLineNr = { fg = p.line_nr_active, bg = p.bg_alt, bold = true },
    LineNr = { fg = p.line_nr, bg = p.bg },
    SignColumn = { fg = p.line_nr, bg = p.bg },
    FoldColumn = { fg = p.comment, bg = p.bg },
    Folded = { fg = p.comment, bg = p.bg_alt },
    EndOfBuffer = { fg = p.bg },
    VertSplit = { fg = p.border },
    WinSeparator = { fg = p.border },
    Visual = { bg = p.bg_visual },
    VisualNOS = { bg = p.bg_visual },
    Search = { fg = p.fg, bg = p.bg_search },
    CurSearch = { fg = p.bg, bg = p.pink },
    IncSearch = { fg = p.bg, bg = p.pink },
    Substitute = { fg = p.bg, bg = p.red },
    MatchParen = { fg = p.pink, bold = true, underline = true },
    NonText = { fg = p.guide },
    Whitespace = { fg = p.guide },
    SpecialKey = { fg = p.guide },
    Conceal = { fg = p.comment },
    Directory = { fg = p.cyan },
    Title = { fg = p.pink, bold = true },
    QuickFixLine = { bg = p.bg_visual },
    WildMenu = { fg = p.bg, bg = p.pink },

    -- Popup menu
    Pmenu = { fg = p.text, bg = p.bg_float },
    PmenuSel = { fg = p.bg, bg = p.pink },
    PmenuSbar = { bg = p.bg_alt },
    PmenuThumb = { bg = p.comment },
    PmenuKind = { fg = p.purple, bg = p.bg_float },
    PmenuExtra = { fg = p.comment, bg = p.bg_float },

    -- Statusline / tabline / winbar
    StatusLine = { fg = p.fg, bg = p.bg_dark },
    StatusLineNC = { fg = p.comment, bg = p.bg_dark },
    TabLine = { fg = p.comment, bg = p.bg },
    TabLineFill = { bg = p.bg_dark },
    TabLineSel = { fg = p.fg, bg = p.bg_alt, bold = true },
    WinBar = { fg = p.text, bg = p.bg },
    WinBarNC = { fg = p.comment, bg = p.bg },

    -- Messages
    ErrorMsg = { fg = p.red, bold = true },
    WarningMsg = { fg = p.orange },
    ModeMsg = { fg = p.fg, bold = true },
    MoreMsg = { fg = p.green },
    Question = { fg = p.cyan },
    MsgArea = { fg = p.text },

    -- Diff
    DiffAdd = { bg = p.diff_add },
    DiffDelete = { fg = p.red, bg = p.diff_delete },
    DiffChange = { bg = p.diff_change },
    DiffText = { bg = p.diff_text },
    Added = { fg = p.green },
    Removed = { fg = p.red },
    Changed = { fg = p.orange },

    -- Spell
    SpellBad = { sp = p.red, undercurl = true },
    SpellCap = { sp = p.orange, undercurl = true },
    SpellLocal = { sp = p.teal, undercurl = true },
    SpellRare = { sp = p.purple, undercurl = true },

    -- Vim syntax
    Comment = { fg = p.comment, italic = true },
    Constant = { fg = p.constant },
    String = { fg = p.string },
    Character = { fg = p.string },
    Number = { fg = p.number },
    Float = { fg = p.number },
    Boolean = { fg = p.constant },
    Identifier = { fg = p.fg_variable },
    Function = { fg = p.func },
    Statement = { fg = p.blue },
    Conditional = { fg = p.blue },
    Repeat = { fg = p.blue },
    Label = { fg = p.blue },
    Operator = { fg = p.blue },
    Keyword = { fg = p.blue },
    Exception = { fg = p.blue },
    PreProc = { fg = p.green },
    Include = { fg = p.green },
    Define = { fg = p.green },
    Macro = { fg = p.green },
    PreCondit = { fg = p.green },
    Type = { fg = p.purple },
    StorageClass = { fg = p.blue },
    Structure = { fg = p.purple },
    Typedef = { fg = p.purple },
    Special = { fg = p.red },
    SpecialChar = { fg = p.red },
    Tag = { fg = p.pink },
    Delimiter = { fg = p.punct },
    SpecialComment = { fg = p.comment, bold = true },
    Debug = { fg = p.red },
    Underlined = { underline = true },
    Ignore = { fg = p.comment },
    Error = { fg = p.red },
    Todo = { fg = p.bg, bg = p.orange, bold = true },

    -- Diagnostics
    DiagnosticError = { fg = p.red },
    DiagnosticWarn = { fg = p.orange },
    DiagnosticInfo = { fg = p.teal },
    DiagnosticHint = { fg = p.comment },
    DiagnosticOk = { fg = p.green },
    DiagnosticVirtualTextError = { fg = p.red, bg = p.error_bg },
    DiagnosticVirtualTextWarn = { fg = p.orange, bg = p.warn_bg },
    DiagnosticVirtualTextInfo = { fg = p.teal, bg = p.bg_alt },
    DiagnosticVirtualTextHint = { fg = p.comment, bg = p.bg_alt },
    DiagnosticUnderlineError = { sp = p.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = p.orange, undercurl = true },
    DiagnosticUnderlineInfo = { sp = p.teal, undercurl = true },
    DiagnosticUnderlineHint = { sp = p.comment, undercurl = true },
    DiagnosticUnnecessary = { fg = p.comment },

    -- LSP
    LspReferenceText = { bg = p.bg_visual },
    LspReferenceRead = { bg = p.bg_visual },
    LspReferenceWrite = { bg = p.bg_visual, underline = true },
    LspInlayHint = { fg = p.comment, bg = p.bg_alt },
    LspCodeLens = { fg = p.comment },
    LspSignatureActiveParameter = { fg = p.func, bold = true },

    -- Treesitter
    ["@variable"] = { fg = p.fg_variable },
    ["@variable.builtin"] = { fg = p.red },
    ["@variable.parameter"] = { fg = p.fg_variable, italic = true },
    ["@variable.member"] = { fg = p.fg_variable },
    ["@constant"] = { fg = p.constant },
    ["@constant.builtin"] = { fg = p.constant },
    ["@module"] = { fg = p.purple },
    ["@label"] = { fg = p.blue },
    ["@string"] = { fg = p.string },
    ["@string.escape"] = { fg = p.red },
    ["@string.special"] = { fg = p.red },
    ["@string.regexp"] = { fg = p.red },
    ["@character"] = { fg = p.string },
    ["@number"] = { fg = p.number },
    ["@boolean"] = { fg = p.constant },
    ["@type"] = { fg = p.purple },
    ["@type.builtin"] = { fg = p.purple },
    ["@attribute"] = { fg = p.green },
    ["@property"] = { fg = p.fg_variable },
    ["@function"] = { fg = p.func },
    ["@function.builtin"] = { fg = p.func },
    ["@function.call"] = { fg = p.func },
    ["@function.method"] = { fg = p.func },
    ["@function.method.call"] = { fg = p.func },
    ["@constructor"] = { fg = p.purple },
    ["@operator"] = { fg = p.blue },
    ["@keyword"] = { fg = p.blue },
    ["@keyword.import"] = { fg = p.green },
    ["@keyword.directive"] = { fg = p.green },
    ["@punctuation.delimiter"] = { fg = p.punct },
    ["@punctuation.bracket"] = { fg = p.punct },
    ["@punctuation.special"] = { fg = p.red },
    ["@comment"] = { fg = p.comment, italic = true },
    ["@comment.error"] = { fg = p.bg, bg = p.red, bold = true },
    ["@comment.warning"] = { fg = p.bg, bg = p.orange, bold = true },
    ["@comment.todo"] = { fg = p.bg, bg = p.orange, bold = true },
    ["@comment.note"] = { fg = p.bg, bg = p.teal, bold = true },
    ["@tag"] = { fg = p.blue },
    ["@tag.attribute"] = { fg = p.pink },
    ["@tag.delimiter"] = { fg = p.punct },
    ["@markup.heading"] = { fg = p.pink, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.link"] = { fg = p.cyan },
    ["@markup.link.url"] = { fg = p.cyan, underline = true },
    ["@markup.raw"] = { fg = p.string },
    ["@markup.list"] = { fg = p.blue },
    ["@diff.plus"] = { fg = p.green },
    ["@diff.minus"] = { fg = p.red },
    ["@diff.delta"] = { fg = p.orange },

    -- gitsigns
    GitSignsAdd = { fg = p.green },
    GitSignsChange = { fg = p.orange },
    GitSignsDelete = { fg = p.red },
    GitSignsCurrentLineBlame = { fg = p.comment, italic = true },

    -- Telescope / fzf style pickers
    TelescopeBorder = { fg = p.pink, bg = p.bg_float },
    TelescopeNormal = { fg = p.text, bg = p.bg_float },
    TelescopeSelection = { fg = p.fg, bg = p.bg_visual },
    TelescopeMatching = { fg = p.pink, bold = true },
    TelescopePromptPrefix = { fg = p.pink },
  }

  for group, spec in pairs(groups) do
    hl(group, spec)
  end
end

--- Follow the desktop light/dark setting (GNOME color-scheme, which is what
--- sway/toggle-theme.sh flips) and the theme family state file, and re-apply
--- the colorscheme when either changes. Call once from your init.lua; it also
--- re-checks on FocusGained and on SIGUSR1 so a running nvim follows the toggle.
function M.sync_with_system()
  local function apply()
    vim.system(
      { "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" },
      { text = true },
      vim.schedule_wrap(function(res)
        local bg = vim.o.background
        if res.code == 0 then
          bg = res.stdout:find("prefer%-light") and "light" or "dark"
        end
        local family = M.read_family()
        if
          vim.o.background ~= bg
          or vim.g.colors_name ~= "bubblegum"
          or vim.g.bubblegum_family ~= family
        then
          vim.o.background = bg
          vim.cmd.colorscheme("bubblegum")
        end
      end)
    )
  end
  apply()
  local group = vim.api.nvim_create_augroup("BubblegumSync", { clear = true })
  vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = apply })
  -- sway/toggle-theme.sh sends SIGUSR1 so open sessions switch immediately.
  vim.api.nvim_create_autocmd("Signal", { group = group, pattern = "SIGUSR1", callback = apply })
end

return M
