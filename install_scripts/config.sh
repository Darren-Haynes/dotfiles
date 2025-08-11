#!/bin/bash

if [ ! -d "$HOME/.config" ]; then
  mkdir "$HOME/.config"
fi

if [ ! -d "$HOME/.X" ]; then
  mkdir "$HOME/.X"
fi

if [ ! -d "$HOME/.screenlayout" ]; then
  mkdir "$HOME/.screenlayout"
fi

ln -s "$HOME/Dotfiles/aliases" "$HOME/.aliases"
ln -s "$HOME/Dotfiles/xinitrc" "$HOME/.xinitrc"
ln -s "$HOME/Dotfiles/xinitrc" "$HOME/.xinitrc"
ln -s "$HOME/Dotfiles/X/Xresources" "$HOME/.Xresources"
ln -s "$HOME/Dotfiles/X/" "$HOME/.X"
xrdb "$HOME/.X/Xresources"

if [ ! -d "$HOME/.screenlayout" ]; then
  mkdir "$HOME/.screenlayout"
fi
ln -s "$HOME/Dotfiles/screenlayout/LG-2k.sh" "$HOME/.screenlayout/LG-2k.sh"

if [ ! -d "$HOME/.ipython/" ]; then
  mkdir -p "$HOME/.ipython/"
fi
ln -s "$HOME/Dotfiles/ipython/profile_darren" "$HOME/.ipython/"
