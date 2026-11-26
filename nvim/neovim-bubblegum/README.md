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

### Theme families

Two families share the colorscheme name `bubblegum`: `bubblegum` (default) and
`shhhed` (sage-green, derived from `zed/themes/shhhed/shhhed.json`). The family is
read at load time from the one-line file `~/.local/state/bubblegum/family`; a
missing, empty or unknown file means `bubblegum`. `sync_with_system()` re-applies
the colorscheme when either the background or the family changes.

### Follow the desktop theme

`sway/toggle-theme.sh` flips the GNOME `color-scheme`. To make Neovim follow it
(at startup and whenever the window regains focus):

```lua
require("bubblegum").sync_with_system()
```

Palettes (`dark`, `light`, `shhhed_dark`, `shhhed_light`): `lua/bubblegum/palette.lua`.
