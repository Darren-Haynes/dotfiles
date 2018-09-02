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

autoload_dir="$HOME/.vim/autoload"
if [ ! -d "$autoload_dir" ]; then
  mkdir -p "$HOME/.vim/autoload/"
  else
    echo ".vim/autoload directory already exists"
fi

vimrc="$HOME/.vimrc"
if [ ! -f "$vimrc" ]; then
  ln -s "$HOME/dotfiles/vim/vimrc" "$HOME/.vimrc"
  else
    echo ".vimrc file already exists."
fi

nvim_dir="$HOME/.config/nvim"
if [ ! -d "$nvim_dir" ]; then
  mkdir -p "$HOME/.config/nvim"
  else
    echo ".config/nvim directory exists."
fi

undo_dir="$HOME/.vim/undodir"
if [ ! -d "$undo_dir" ]; then
  mkdir -p "$HOME/.vim/undodir"
  else
    echo ".vim/undodir directory already exists."
fi

initvim="$HOME/.config/nvim/init.vim"
if [ ! -f "$initvim" ]; then
  ln -s "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"
  else
    echo "init.vim file already exists."
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
