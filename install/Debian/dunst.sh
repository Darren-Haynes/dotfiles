#!/bin/bash

sudo apt-get install -y dunst

if [ ! -d "$HOME/.config/dunst/" ]; then
  mkdir "$HOME/.config/dunst/"
fi

ln -s "$HOME/Dotfiles/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
