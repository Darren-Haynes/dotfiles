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
    lxappearance \
    pulseaudio

if [ ! -d "$HOME/.config" ]; then 
    mkdir $HOME/.config
fi
ln -s $HOME/Dotfiles/bspwm $HOME/.config/
ln -s $HOME/Dotfiles/sxhkd $HOME/.config/
ln -s $HOME/Dotfiles/X/xinitrc $HOME/.xinitrc
ln -s $HOME/Dotfiles/aliases $HOME/.aliases

source "$HOME/Dotfiles/install_scripts/fonts.sh"
source "$HOME/Dotfiles/install_scripts/neovim.sh"
source "$HOME/Dotfiles/install_scripts/kitty.sh"
source "$HOME/Dotfiles/install_scripts/chrome.sh"
source "$HOME/Dotfiles/install_scripts/lf.sh"
source "$HOME/Dotfiles/install_scripts/oh-my-bash.sh"

