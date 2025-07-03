#!/bin/bash

if [ ! -d "$HOME/.local/share/icons" ]; then
  mkdir -p $HOME/.local/share/icons
fi

if [ ! -d "$HOME/.local/share/themes" ]; then
  mkdir $HOME/.local/share/themes
fi

if [ ! -d "$HOME/.config/gtk-3.0" ]; then
  mkdir -p $HOME/.config/gtk-3.0
fi
