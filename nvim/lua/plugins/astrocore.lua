-- Configure formatting options and trailing whitespace cleanup autocommands

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- 1. Enable Native Format-on-Save
    formatting = {
      format_on_save = {
        enabled = true, -- Automatically trigger formatting when saving files
        allow_filetypes = {}, -- Empty table means it runs on ALL supported filetypes (like TS/JS)
      },
      timeout_ms = 3000, -- Give formatters like Prettier/Stylua 3 seconds before timing out
    },

    -- 2. Clean up trailing whitespace using Neovim Autocommands
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
