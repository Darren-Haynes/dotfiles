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
    pm-utils \
    upower \
    xfconf \
    libnotify4 \
    thunar \
    gpick \
    vim \
    man \
    mpv \
    lxappearance \
    pulseaudio \
    speedcrunch \
    bpytop \
    lpr \
    cups \
    xsel \
    unzip \
    gtk2-engines-murrine

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
source "$HOME/Dotfiles/install_scripts/MS-Fonts.sh"

