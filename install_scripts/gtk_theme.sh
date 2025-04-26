#!/bin/bash

if [ ! -d "$HOME/.local/share/icons" ]; then
  mkdir $HOME/.local/share/icons
fi

if [ ! -d "$HOME/.local/share/themes" ]; then
  mkdir $HOME/.local/share/themes
fi

if [ ! -d "$HOME/.config/gtk-3.0" ]; then
  mkdir $HOME/.config/gtk-3.0
fi

cp -R $HOME/Dotfiles/themes/Tokyonight-Dark-BL-LB $HOME/.local/share/themes/
cp -R $HOME/Dotfiles/icons/Tokyonight-Dark $HOME/.local/share/icons/
ln -s $HOME/Dotfiles/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini
