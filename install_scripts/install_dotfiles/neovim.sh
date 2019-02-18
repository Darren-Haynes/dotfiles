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

undo_dir="$HOME/.vim/undodir"
if [ ! -d "$undo_dir" ]; then
  mkdir -p "$HOME/.vim/undodir"
  echo "~/.vim/undodir directory created."
  else
    echo "Skip making .vim/undodir, directory already exists."
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
