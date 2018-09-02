#!/bin/bash

# Install i3wm, dmenu and compositor
sudo yes Y | apt install \
  i3-wm \
  dmenu \
  compton

i3dir="$HOME/.config/i3"
if [ ! -d "$i3dir" ]; then
  mkdir -p "$HOME/.config/i3"
  else
    echo "i3 config dir already exists"
fi

i3config="$HOME/.config/i3/config"
if [ ! -f "$i3config" ]; then
  ln -s "$HOME/dotfiles/i3/config" "$HOME/.config/i3/config"
  else
    echo "i3 config file already exists"
fi
