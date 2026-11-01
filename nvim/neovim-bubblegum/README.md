# Bubblegum for Neovim

Dark and light variants matching the rest of the Bubblegum setup (Zed, GTK, dunst, rofi).
Plain Lua, no dependencies. Neovim 0.10+.

## Use

Put this directory on the runtimepath, e.g. with lazy.nvim:

```lua
{ dir = "~/Dotfiles/nvim/neovim-bubblegum", lazy = false, priority = 1000,
  config = function() vim.cmd.colorscheme("bubblegum") end }
```

or without a plugin manager: `vim.opt.rtp:prepend(vim.fn.expand("~/Dotfiles/nvim/neovim-bubblegum"))`.

The variant follows `:set background=dark|light`.

### Follow the desktop theme

`sway/toggle-theme.sh` flips the GNOME `color-scheme`. To make Neovim follow it
(at startup and whenever the window regains focus):

```lua
require("bubblegum").sync_with_system()
```

Palette: `lua/bubblegum/palette.lua`.
