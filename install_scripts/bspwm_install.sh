#!/bin/bash

sudo apt-get install -y \
    xinit \
    lm-sensors \
    mesa-utils \
    x11-xserver-utils \
    libxcb-xkb1 \
    bspwm \
    sxhkd \
    curl \
    wget \
    feh \
    imagemagick \
    xz-utils \
    xfce4-power-manager \
    thunar \
    gpick \
    vim \
    man \
    mpv \
    lxappearance

ln -s $HOME/Dotfiles/bspwm $HOME/.config
ln -s $HOME/Dotfiles/sxkhd $HOME/.config
ln -s $HOME/Dotfiles/X/xinitrc $HOME/.xinitrc
ln -s $HOME/Dotfiles/aliases $HOME/.aliases

source "$HOME/Dotfiles/install_scripts/fonts.sh"
source "$HOME/Dotfiles/install_scripts/neovim.sh"
source "$HOME/Dotfiles/install_scripts/kitty.sh"
source "$HOME/Dotfiles/install_scripts/chrome.sh"
source "$HOME/Dotfiles/install_scripts/lf.sh"

