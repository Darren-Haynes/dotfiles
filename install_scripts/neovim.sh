#!/bin/bash

# Install and configure Neovim
sudo apt-get install -y ssh-askpass-gnome
sudo apt-get install -y ssh-askpass

cd $HOME/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
sudo rm -rf /opt/nvim*
sudo tar -C /opt -xzf nvim-linux-arm64.tar.gz
rm nvim-linux-arm64.tar.gz
cd $HOME

printf '\nexport PATH="$PATH:/opt/nvim-linux-arm64/bin"\n' >> $HOME/.bashrc
printf '\nexport PATH="$PATH:/opt/nvim-linux-arm64/bin"\n' >> $HOME/.profile

#lazynvim
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter $HOME/.config/nvim
rm -rf $HOME/.config/nvim/.git

source $HOME/.bashrc
