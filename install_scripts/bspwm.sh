#!/bin/bash

sudo apt-get install -y \
  bspwm \
  sxhkd \                 # bspwm keyboard interface
  libxcb-xkb1 \           # X keyboard controller
  feh \                   # manage wallpaper
  pm-utils \              # power management utils
  upower \                # freedesktop power management
  xfce4-power-manager \   # power manager
  xfconf \                # xfce settings
  lxappearance \          # theme management
  gtk2-engines-murrine \  # glass purdy
  libnotify4 \            # desktop notifications
  pulseaudio              # audio

ln -s $HOME/Dotfiles/bspwm $HOME/.config/
ln -s $HOME/Dotfiles/sxhkd $HOME/.config/

