#!/bin/bash

# Install and configure Neovim
sudo apt install \
  software-properties-common \
  python-dev \
  python-pip \
  python3-dev \
  python3-pip \

sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt install vim-scripts
sudo apt install neovim

undo_dir="$HOME/.vim/undodir"
if [ ! -d "$undo_dir" ]; then
  sudo mkdir -p "$HOME/.vim/undodir"
  echo "~/.vim/undodir directory created."
  sudo chown -R $USER:$(id -g -n $USER) "$HOME/.vim/undodir"
  else
    echo "Skip making .vim/undodir, directory already exists."
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo chown -R $USER:$(id -g -n $USER) "$HOME/.vim/autoload"
