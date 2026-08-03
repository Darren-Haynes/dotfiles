-- lua/plugins/wezterm-move.lua
return {
  "letieu/wezterm-move.nvim",
  -- Ensure lazy loading is driven ONLY by these keys
  keys = {
    { "<C-h>", function() require("wezterm-move").move("h") end, desc = "Move WezTerm Left" },
    { "<C-j>", function() require("wezterm-move").move("j") end, desc = "Move WezTerm Down" },
    { "<C-k>", function() require("wezterm-move").move("k") end, desc = "Move WezTerm Up" },
    { "<C-l>", function() require("wezterm-move").move("l") end, desc = "Move WezTerm Right" },

    -- Neovim Resize (Native commands, NOT the plugin)
    { "<M-h>", function() vim.cmd("vertical resize -3") end },
    { "<M-l>", function() vim.cmd("vertical resize +3") end },
    { "<M-k>", function() vim.cmd("resize -3") end },
    { "<M-j>", function() vim.cmd("resize +3") end },
  },
}   
