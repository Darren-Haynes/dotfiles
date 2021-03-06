#!/bin/bash

# Install ranger and cp config files to user
sudo apt install feh
sudo apt install w3m
sudo apt install highlight
sudo apt install ranger
ranger_dir="$HOME/.config/ranger"
if [ ! -d "$ranger_dir" ]; then
  mkdir -p "$HOME/.config/ranger"
  ranger --copy-config=all
  echo "$HOME/.config/ranger dir created."
  else
    echo "Skip making ~/.config/ranger dir, it already exists"
fi
echo 'Ranger installed and configs copied to ~/.config/ranger/'
