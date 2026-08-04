-- Customize Mason Overrides

---@type LazySpec
return {
  -- Use mason-tool-installer to automatically download tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", -- Lua LSP
        "stylua",              -- Lua Formatter
        "debugpy",             -- Python Debugger
        "tree-sitter-cli",     -- Treesitter helper
      },
    },
  },

  -- Correctly hooks into AstroNvim v4's LSP management
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Correct modern TS Server package name for AstroNvim
      table.insert(opts.ensure_installed, "vtsls") 
    end,
  },
}
