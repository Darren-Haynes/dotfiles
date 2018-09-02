#!/bin/bash

# Install polybar
sudo yes Y | apt install \
    cmake \
    libxcb1-dev \
    libxcb-util0-dev \
    python-xcbgen \
    xcb-proto \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-cursor-dev \
    libasound2-dev \
    libpulse-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libcurl4-openssl-dev \
    libiw-dev \
    libnl-3-dev

executable="$(which polybar)"
polybar="polybar"
if [[ "$executable" == *"$polybar"* ]]; then
  echo "Polybar is already installed."
  else
  cd
  git clone --recursive https://github.com/jaagr/polybar
  mkdir polybar/build
  cd polybar/build
  cmake ..
  sudo make install
  cd
  rm -rf polybar
fi

polybar_dir="$HOME/.config/polybar"
if [ ! -d "$polybar_dir" ]; then
  ln -s "$HOME/dotfiles/polybar" "$HOME/.config/polybar"
  else
    echo "Polubar config folder already exists"
fi

nmd_dir="$HOME/.config/networkmanager-dmenu"
if [ ! -d "$nmd_dir" ]; then
  ln -s "$HOME/dotfiles/networkmanager-dmenu" "$HOME/.config/networkmanager-dmenu"
  else
    echo "Networkmanager-dmenu config folder already exists"
fi
