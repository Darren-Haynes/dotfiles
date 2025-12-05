#!/bin/bash

set -eu



# Install and configure Neovim


#lazynvim
if [ -d "$HOME/.config/nvim.bak" ]; then
  rm -rf "$HOME/.config/nvim.bak"
  mv ~/.config/nvim{,.bak}
fi

# optional but recommended
if [ -d "$HOME/.local/share/nvim.bak" ]; then
  rm -rf "$HOME/.local/share/nvim.bak"
  mv ~/.local/share/nvim{,.bak}
fi
if [ -d "$HOME/.local/state/nvim.bak" ]; then
  rm -rf "$HOME/.local/state/nvim.bak"
  mv ~/.local/state/nvim{,.bak}
fi
if [ -d "$HOME/.cache/nvim.bak" ]; then
  rm -rf "$HOME/.cache/nvim.bak"
  mv ~/.cache/nvim{,.bak}
fi

git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

# Pyenv virtual env default for neovim
pyenv virtualenv 3.13.3 nvim-3.13.3.venv
pyenv activate nvim-3.13.3.venv
pip install pynvim

# Add personal configs to init.lua
rm -f "$HOME/.config/nvim/init.lua"
ln -s "$HOME/Dotfiles/nvim/init.lua" "$HOME/.config/nvim/init.lua"

rm -f "$HOME/.config/nvim/lua/plugins/python.lua"
ln -s "$HOME/Dotfiles/nvim/python.lua" "$HOME/.config/nvim/lua/plugins/"

rm -f "$HOME/.config/nvim/lua/plugins/themes.lua"
ln -s "$HOME/Dotfiles/nvim/themes.lua" "$HOME/.config/nvim/lua/plugins/"

rm -f "$HOME/.config/nvim/lua/config/keymaps.lua"
ln -s "$HOME/Dotfiles/nvim/keymaps.lua" "$HOME/.config/nvim/lua/config/"

rm -f "$HOME/.config/nvim/lua/config/ui.lua"
ln -s "$HOME/Dotfiles/nvim/ui.lua" "$HOME/.config/nvim/lua/plugins/"

rm -f "$HOME/.config/nvim/lua/config/project.lua"
ln -s "$HOME/Dotfiles/nvim/project.lua" "$HOME/.config/nvim/lua/plugins/"

if [ ! -d "$HOME/.config/nvim/after/ftplugin" ]; then
  mkdir -p "$HOME/.config/nvim/after/ftplugin/"
  ln -s "$HOME/Dotfiles/nvim/ftplugin/python.lua" "$HOME/.config/nvim/lua/plugins/"
fi
source "$HOME/.bashrc"
