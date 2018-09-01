#!/bin/bash

# Install i3wm, xinit, xorg and compositor
sudo yes Y | apt install \
  i3-wm \
  dmenu \
  compton \
  xorg \
  xinit
mkdir -p "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3/config" "$HOME/.config/i3/config"

# Install drivers
sudo yes Y | apt install \
  mesa-utils \
  mesa-utils-extra \

# Install restricted extras
sudo yes Y | echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo yes Y | apt install ubuntu-restricted-extras

