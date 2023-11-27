#!/bin/bash

sudo apt-get install -y \
  xinit \
  x11-server-utils \
  mesa-utils 

ln -s $HOME/Dotfiles/X/xinitrc $HOME/.xinitrc
