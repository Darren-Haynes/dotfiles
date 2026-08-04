-- Configure formatting options and trailing whitespace cleanup autocommands

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- STRUCTURAL GLOBAL OPTIONS (HIDE TABLINE BY DEFAULT)
    options = {
      opt = {
        showtabline = 0, -- 0 completely hides the tabline on boot
      },
    },

    -- ENABLE NATIVE FORMAT-ON-SAVE
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {}, -- Empty table means it runs on ALL supported filetypes (like TS/JS)
      },
      timeout_ms = 3000, -- Give formatters like Prettier/Stylua 3 seconds before timing out
    },

    -- CUSTOM DEBUGGER KEYMAP MAPPINGS
    mappings = {
      -- Normal mode keymaps
      n = {
        ["<Leader>dj"] = { function() require("dap").step_over() end, desc = "Step over" },
        ["<Leader>do"] = { function() require("dap").step_out() end, desc = "Step out" },
        ["<Leader>dO"] = false,
      },
    },

    -- CLEAN UP TRAILING WHITESPACE USING NEOVIM AUTOCOMMANDS
    autocmds = {
      -- Create a custom group so these functions don't duplicate on reload
      whitespace_cleanup = {
        {
          event = "BufWritePre", -- Trigger right BEFORE the file writes to disk
          desc = "Automatically remove trailing whitespaces on save",
          callback = function()
            -- Save user's current cursor position so it doesn't jump around
            local save_cursor = vim.fn.getpos "."
            -- Run a regular expression substitution to clear empty end spaces
            vim.cmd [[%s/\s\+$//e]]
            -- Restore cursor right back to where you were typing
            vim.fn.setpos(".", save_cursor)
          end,
        },
      },
    },
  },
}
