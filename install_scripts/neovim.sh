#!/bin/bash

arch=$(uname -m)

# Install lua
sudo apt-get install -y build-essential
sudo apt-get install -y libreadline-dev
sudo apt-get install -y unzip
sudo apt-get install -y libssl-dev
sudo apt-get install -y lua5.1
sudo apt-get install -y luajit
sudo apt-get install -y luarocks

# Install useful dependencies for full functioning neovim
sudo apt-get install -y ripgrep
sudo apt-get install -y fd-find
sudo apt-get install -y fzf
sudo apt-get install -y nodejs
sudo apt-get install -y npm
sudo apt-get install -y texlive

if [ ! -d "$HOME/GitClones/Lazygit" ]; then
  mkdir -p "$HOME/GitClones/Lazygit"
fi

cd "$HOME/GitClones/Lazygit" || exit
curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.49.0/lazygit_0.49.0_Linux_"${arch}".tar.gz
tar xzf lazygit.tar.gz
sudo install lazygit -D -t /usr/local/bin/
cd "$HOME" || exit

sudo apt-get install -y ssh-askpass-gnome
sudo apt-get install -y ssh-askpass

# Install and configure Neovim
cd "$HOME/Downloads" || exit
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-"${arch}".tar.gz
sudo rm -rf /opt/nvim*
sudo tar -C /opt -xzf nvim-linux-"${arch}".tar.gz
rm nvim-linux-"${arch}".tar.gz
cd "$HOME" || exit

printf '\nexport PATH="$PATH:/opt/nvim-linux-${arch}/bin"\n' >>"$HOME/.bashrc"
printf '\nexport PATH="$PATH:/opt/nvim-linux-${arch}/bin"\n' >>"$HOME/.profile"

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
rm -f "$HOME/.config/nvim/lua/plugins/zellij.lua"
ln -s "$HOME/Dotfiles/nvim/zellij.lua" "$HOME/.config/nvim/lua/plugins/"
rm -f "$HOME/.config/nvim/lua/config/keymaps.lua"
ln -s "$HOME/Dotfiles/nvim/keymaps.lua" "$HOME/.config/nvim/lua/config/"
rm -f "$HOME/.config/nvim/lua/config/ui.lua"
ln -s "$HOME/Dotfiles/nvim/ui.lua" "$HOME/.config/nvim/lua/plugins/"

if [ ! -d "$HOME/.config/nvim/after/ftplugin" ]; then
  mkdir -p "$HOME/.config/nvim/after/ftplugin/"
  ln -s "$HOME/Dotfiles/nvim/ftplugin/python.lua" "$HOME/.config/nvim/lua/plugins/"
fi
source "$HOME/.bashrc"
