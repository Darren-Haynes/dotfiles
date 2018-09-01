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

cd
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install
cd
rm -rf polybar
ln -s "$HOME/dotfiles/polybar" "$HOME/.config/polybar"
ln -s "$HOME/dotfiles/networkmanager-dmenu" "$HOME/.config/networkmanager-dmenu"
