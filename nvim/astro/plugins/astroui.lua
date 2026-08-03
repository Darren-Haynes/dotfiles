return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- Set the global runtime theme to use your custom definitions
    colorscheme = "astrodark",

    -- Build the precise Dram color variables natively
    palettes = {
      astrodark = {
        bg = "#0f3b3a",           -- Deep dark teal (Editor background)
        bg_highlight = "#155352", -- Medium teal surface (Active lines/menus)
        fg = "#b1c9c3",           -- Seafoam white (Primary text)
        accent = "#00c420",       -- Bright green (Selections / Git Add)
        text_muted = "#819993",   -- Grayed teal (Comments)
        
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

    -- Map variables explicitly to Neovim structural components
    highlights = {
      astrodark = {
        -- ==========================================
        -- CORE SYNTAX OVERRIDES (Aligned with Zed)
        -- ==========================================
        -- Functions & Methods (Zed Gold)
        ["@function"] = { fg = "#cfc041" },
        ["@function.builtin"] = { fg = "#cfc041" },
        ["@function.call"] = { fg = "#cfc041" },
        ["@method"] = { fg = "#cfc041" },
        ["@method.call"] = { fg = "#cfc041" },

        -- Keywords & Properties (Zed Cyan/Teal)
        ["@keyword"] = { fg = "#77bfcf" },
        ["@keyword.function"] = { fg = "#77bfcf" },
        ["@keyword.operator"] = { fg = "#a64a2e" }, -- Match operator color
        ["@property"] = { fg = "#77bfcf" },
        ["@variable.member"] = { fg = "#77bfcf" },

        -- Brackets & Punctuation
        ["@punctuation.bracket"] = { fg = "#77bfcf" },
        ["@punctuation.delimiter"] = { fg = "#b1c9c3" },
        ["@punctuation.special"] = { fg = "#819993" },

        -- Variables & Parameters (Zed base text color)
        ["@variable"] = { fg = "#b1c9c3" },
        ["@variable.parameter"] = { fg = "#b1c9c3" },
        ["@variable.builtin"] = { fg = "#b1c9c3" },

        -- Types & Enums (Zed Pure White / Rust-orange)
        ["@type"] = { fg = "#ffffff" },
        ["@type.builtin"] = { fg = "#ffffff" },
        ["@type.definition"] = { fg = "#ffffff" },

        -- Constants & Booleans
        ["@constant"] = { fg = "#a666ba" },
        ["@constant.builtin"] = { fg = "#a666ba" },
        ["@boolean"] = { fg = "#0096ff" },

        -- Literals (Numbers, Operators & Strings)
        ["@number"] = { fg = "#a64a2e" },
        ["@float"] = { fg = "#a64a2e" },
        ["@operator"] = { fg = "#a64a2e" },
        ["@string"] = { fg = "#98875f" },
        ["@string.escape"] = { fg = "#98875f" },
        ["@string.regex"] = { fg = "#98875f" },
        ["@string.special.symbol"] = { fg = "#cfc041" },

        -- Tags (HTML / JSX)
        ["@tag"] = { fg = "#b1c9c3" },
        ["@tag.attribute"] = { fg = "#77bfcf" },
        ["@tag.delimiter"] = { fg = "#b1c9c3" },

        -- ==========================================
        -- EXISTING PLUGIN & UI HIGHLIGHTS (Retained)
        -- ==========================================
        -- Base Editor overrides
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
        
        -- Neo-tree / File managers canvas matching
        NeoTreeNormal = { bg = "#155352", fg = "#b1c9c3" },
        NeoTreeNormalNC = { bg = "#155352", fg = "#b1c9c3" },
        
        -- HEIRLINE TABBAR OVERRIDES
        HeirlineTabline = { bg = "#155352" },
        TabLineFill = { bg = "#155352" },
        TabLine = { bg = "#155352", fg = "#819993" },
        TabLineSel = { bg = "#0f3b3a", fg = "#b1c9c3", bold = true },
        
        -- HEIRLINE STATUSLINE OVERRIDES
        StatusLine = { bg = "#155352", fg = "#b1c9c3" },
        StatusLineNC = { bg = "#155352", fg = "#819993" },
        HeirlineStatusline = { bg = "#155352" },

        -- HEIRLINE SPECIFIC WINBAR
        HeirlineWinBar = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineWinBarNC = { bg = "#0f3b3a", fg = "#819993" },
        HeirlineFileIcon = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineFileName = { bg = "#0f3b3a", fg = "#b1c9c3" },
        HeirlineFilePath = { bg = "#0f3b3a", fg = "#b1c9c3" },

        -- STATUSLINE MODE BLOCKS 
        Heirline_normal = { bg = "#b1c9c3", fg = "#0f3b3a", bold = true },  
        Heirline_insert = { bg = "#00c420", fg = "#0f3b3a", bold = true },  
        Heirline_visual = { bg = "#e99f10", fg = "#0f3b3a", bold = true },  
        Heirline_replace = { bg = "#d74200", fg = "#b1c9c3", bold = true }, 
        Heirline_command = { bg = "#0096ff", fg = "#0f3b3a", bold = true }, 

        -- NVIM-CMP COMPLETION POPUP WINDOWS
        CmpPmenu = { bg = "#155352", fg = "#b1c9c3" },
        CmpPmenuBorder = { fg = "#559392", bg = "#155352" },
        CmpPmenuSel = { bg = "#1b5458", fg = "#b1c9c3", bold = true },
        CmpDoc = { bg = "#0f3b3a", fg = "#b1c9c3" },
        CmpDocBorder = { fg = "#357372", bg = "#0f3b3a" },
        
        -- GITSIGNS PLUG-IN SIDEBAR HIGHLIGHTS
        GitSignsAdd = { fg = "#009403", bg = "NONE" },
        GitSignsChange = { fg = "#e99f10", bg = "NONE" },
        GitSignsDelete = { fg = "#d74200", bg = "NONE" },
        
        -- Window Borders and dividers
        FloatBorder = { fg = "#559392", bg = "#155352" },
        LineNr = { fg = "#559392" },
        CursorLineNr = { fg = "#b1c9c3", bold = true },
      },
    },
  },
}
