#!/bin/bash

sudo apt-get install -y xinit
sudo apt-get install -y x11-server-utils
sudo apt-get install -y mesa-utils 

ln -s $HOME/Dotfiles/X/xinitrc $HOME/.xinitrc
