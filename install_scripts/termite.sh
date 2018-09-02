#!/bin/bash

executable="$(which termite)"
termite="termite"
echo "$termite"
if [[ "$executable" == *"$termite"* ]]; then
  echo "Termite is already installed."
  else
    git clone https://github.com/Corwind/termite-install.git
    ./termite-install/termite-install.sh
    sudo yes Y | rm -rf termite termite-install vte-ng
fi

termite_dir="$HOME/.config/termite"
if [ ! -d "$termite_dir" ]; then
  ln -s "$HOME/dotfiles/termite" "$HOME/.config/"
  else
    echo "Termite config folder already exists"
fi

# Theres a termite color changer script in bin folder
bin_dir="$HOME/bin"
if [ ! -d "$bin_dir" ]; then
  ln -s "$HOME/dotfiles/bin" "$HOME/bin"
  else
    echo "User bin folder already exists"
fi
