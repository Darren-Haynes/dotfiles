#!/bin/bash

# Install and configure Neovim
sudo apt install -y python3-neovim

os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/tmp
working_dir=$HOME/tmp
if [[ "$os" = "ID=debian" ]]; then
    echo "Installing Neovim for Debian"
    echo "$working_dir"
    url=https://github.com/neovim/neovim/releases/download/v0.9.4/nvim.appimage
    echo "$url"
    wget -P $working_dir $url
    chmod u+x "$working_dir/nvim.appimage"
    sudo mv "$working_dir/nvim.appimage" /usr/local/bin
    rm -rf $working_dir
    echo "Neovim v0.9.4 has been install to /usr/local/bin"
fi


