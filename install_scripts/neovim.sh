#!/bin/bash

# Install and configure Neovim
sudo yes Y | apt install \
  software-properties-common \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \

sudo yes Y | apt-add-repository ppa:neovim-ppa/stable
sudo yes Y | apt-get update
sudo yes Y | apt install neovim
mkdir -p "$HOME/.vim/autoload/"
ln -s "$HOME/dotfiles/vim/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config/nvim"
sudo yes Y | mkdir "$HOME/.vim/undodir"
ln -s "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
