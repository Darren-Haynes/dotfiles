-- Custom AstroUI Theme Overrides (Deep Teal & Zed Hybrid)

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- Use the default astrodark profile and overlay your colors on top
    colorscheme = "astrodark",

    -- Override the core astrodark palette variables natively
    palettes = {
      astrodark = {
        bg = "#0f3b3a", -- Deep dark teal (Editor background)
        bg_highlight = "#155352", -- Medium teal surface (Active lines/menus)
        fg = "#b1c9c3", -- Seafoam white (Primary text)
        accent = "#00c420", -- Bright green (Selections / Git Add)
        text_muted = "#819993", -- Grayed teal (Comments)

        -- HEIRLINE CORE LAYOUT OVERRIDES
        tabbar_bg = "#155352",
        statusline_bg = "#155352",

        -- Map standard ANSI language keys explicitly
        red = "#d74200",
        green = "#009403",
        yellow = "#e99f10",
        blue = "#0096ff",
        purple = "#b154cf",
        cyan = "#77bfc3",
        white = "#b1c9c3",
      },
    },

    -- Map your syntax components to the astrodark profile directly
    highlights = {
      astrodark = {
        -- ==========================================
        -- CORE SYNTAX OVERRIDES (Aligned with Zed)
        -- ==========================================
        ["@function"] = { fg = "#cfc041" },
        ["@function.builtin"] = { fg = "#cfc041" },
        ["@function.call"] = { fg = "#cfc041" },
        ["@method"] = { fg = "#cfc041" },
        ["@method.call"] = { fg = "#cfc041" },

        ["@keyword"] = { fg = "#77bfcf" },
        ["@keyword.function"] = { fg = "#77bfcf" },
        ["@keyword.operator"] = { fg = "#a64a2e" },
        ["@property"] = { fg = "#77bfcf" },
        ["@variable.member"] = { fg = "#77bfcf" },

        ["@punctuation.bracket"] = { fg = "#77bfcf" },
        ["@punctuation.delimiter"] = { fg = "#b1c9c3" },
        ["@punctuation.special"] = { fg = "#819993" },

        ["@variable"] = { fg = "#b1c9c3" },
        ["@variable.parameter"] = { fg = "#b1c9c3" },
        ["@variable.builtin"] = { fg = "#b1c9c3" },

        ["@type"] = { fg = "#ffffff" },
        ["@type.builtin"] = { fg = "#ffffff" },
        ["@type.definition"] = { fg = "#ffffff" },

        ["@constant"] = { fg = "#a666ba" },
        ["@constant.builtin"] = { fg = "#a666ba" },
        ["@boolean"] = { fg = "#0096ff" },

        ["@number"] = { fg = "#a64a2e" },
        ["@float"] = { fg = "#a64a2e" },
        ["@operator"] = { fg = "#a64a2e" },
        ["@string"] = { fg = "#98875f" },
        ["@string.escape"] = { fg = "#98875f" },
        ["@string.regex"] = { fg = "#98875f" },
        ["@string.special.symbol"] = { fg = "#cfc041" },

        ["@tag"] = { fg = "#b1c9c3" },
        ["@tag.attribute"] = { fg = "#77bfcf" },
        ["@tag.delimiter"] = { fg = "#b1c9c3" },

        -- ==========================================
        -- SYSTEM UI OVERRIDES
        -- ==========================================
        Normal = { bg = "#0f3b3a", fg = "#b1c9c3" },
        NormalNC = { bg = "#0f3b3a", fg = "#b1c9c3" },
        NormalFloat = { bg = "#155352", fg = "#b1c9c3" },
        Comment = { fg = "#009403", italic = true },
        ["@comment"] = { fg = "#009403", italic = true },
        ["@comment.documentation"] = { fg = "#009403" },

        CursorLine = { bg = "#155352" },
        Visual = { bg = "#1b5458" },
        Search = { bg = "#cfc041", fg = "#0f3b3a" },
        WinSeparator = { fg = "#357372", bg = "#0f3b3a" },
        VertSplit = { fg = "#357372", bg = "#0f3b3a" },
        WinBar = { bg = "#0f3b3a", fg = "#b1c9c3" },
        MatchParen = { bg = "#155352", fg = "#00c420", bold = true },

        -- NEO-TREE PANEL SYNC
        NeoTreeNormal = { bg = "#155352", fg = "#b1c9c3" },
        NeoTreeNormalNC = { bg = "#155352", fg = "#b1c9c3" },
        NeoTreeTabActive = { bg = "#155352", fg = "#b1c9c3", bold = true },
        NeoTreeTabInactive = { bg = "#155352", fg = "#819993" },
        NeoTreeTabBar = { bg = "#155352", fg = "#155352" },
        NeoTreeTabBackground = { bg = "#155352", fg = "#155352" },
        NeoTreeHeaderBar = { bg = "#155352", fg = "#155352" },
        NeoTreeTabSeparator = { bg = "#155352", fg = "#155352" },
        NeoTreeTabSeparatorActive = { bg = "#155352", fg = "#155352" },
        NeoTreeTabSeparatorInactive = { bg = "#155352", fg = "#155352" },
        NeoTreeWindowsDefined = { bg = "#155352", fg = "#155352" },
        NeoTreeWinSeparator = { fg = "#357372", bg = "#155352" },

        -- HEIRLINE UI OVERRIDES
        HeirlineTabline = { bg = "#0f3b3a" },
        TabLineFill = { bg = "#0f3b3a" },
        TabLine = { bg = "#155352", fg = "#819993" },
        TabLineSel = { bg = "#0f3b3a", fg = "#b1c9c3", bold = true },
        StatusLine = { bg = "#155352", fg = "#b1c9c3" },
        StatusLineNC = { bg = "#155352", fg = "#819993" },
        HeirlineStatusline = { bg = "#155352" },
        HeirlineWinBar = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineWinBarNC = { bg = "#0f3b3a", fg = "#819993" },
        HeirlineFileIcon = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineFileName = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineFilePath = { bg = "#0f3b3a", fg = "#b1c9c3" },

        -- STATUSLINE MODES
        Heirline_normal = { bg = "#b1c9c3", fg = "#0f3b3a", bold = true },
        Heirline_insert = { bg = "#00c420", fg = "#0f3b3a", bold = true },
        Heirline_visual = { bg = "#e99f10", fg = "#0f3b3a", bold = true },
        Heirline_replace = { bg = "#d74200", fg = "#b1c9c3", bold = true },
        Heirline_command = { bg = "#0096ff", fg = "#0f3b3a", bold = true },

        -- AUTO-COMPLETE POPUPS
        CmpPmenu = { bg = "#155352", fg = "#b1c9c3" },
        CmpPmenuBorder = { fg = "#559392", bg = "#155352" },
        CmpPmenuSel = { bg = "#1b5458", fg = "#b1c9c3", bold = true },
        CmpDoc = { bg = "#0f3b3a", fg = "#b1c9c3" },
        CmpDocBorder = { fg = "#357372", bg = "#0f3b3a" },

        -- MISC BORDERS & LINES
        GitSignsAdd = { fg = "#009403", bg = "NONE" },
        GitSignsChange = { fg = "#e99f10", bg = "NONE" },
        GitSignsDelete = { fg = "#d74200", bg = "NONE" },
        FloatBorder = { fg = "#559392", bg = "#155352" },
        LineNr = { fg = "#559392" },
        CursorLineNr = { fg = "#b1c9c3", bold = true },
      },
    },
  },
}
