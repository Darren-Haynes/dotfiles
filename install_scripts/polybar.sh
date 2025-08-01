#!/bin/bash

sudo apt-get install -y polybar

if [ ! -d "$HOME/.config/polybar/" ]; then
  mkdir -p "$HOME/.config/polybar/"
fi

ln -s "$HOME/Dotfiles/polybar/colors.ini" "$HOME/.config/polybar/color.ini"
ln -s "$HOME/Dotfiles/polybar/config.ini" "$HOME/.config/polybar/config.ini"
ln -s "$HOME/Dotfiles/polybar/modules.ini" "$HOME/.config/polybar/modules.ini"
