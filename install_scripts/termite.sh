#!/bin/bash

# Install Termite
git clone https://github.com/Corwind/termite-install.git
./termite-install/termite-install.sh
sudo yes Y | rm -rf termite termite-install vte-ng
ln -s "$HOME/dotfiles/termite" "$HOME/.config/"

# Theres a termite color changer script in bin folder
ln -s "$HOME/dotfiles/bin" "$HOME/bin"
