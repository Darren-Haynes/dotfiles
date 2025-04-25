#!/bin/bash

sudo apt-get install bspwm -y
sudo apt-get install sxhkd -y                # bspwm keyboard interface
sudo apt-get install libxcb-xkb1 -y          # x keyboard controller
sudo apt-get install feh -y                  # manage wallpaper
sudo apt-get install pm-utils -y             # power management utils
sudo apt-get install upower -y               # freedesktop power management
sudo apt-get install xfce4-power-manager -y  # power manager
sudo apt-get install xfconf -y               # xfce settings
sudo apt-get install lxappearance -y         # theme management
sudo apt-get install gtk2-engines-murrine -y # glass purdy
sudo apt-get install libnotify4 -y           # desktop notifications
sudo apt-get install pulseaudio -y           # audio
sudo apt-get install i3lock -y               # simple lock screen
sudo apt-get install arandr -y               # screen management
sudo apt-get install xorg -y                 # cause you need windows

ln -s $HOME/Dotfiles/bspwm $HOME/.config/
ln -s $HOME/Dotfiles/sxhkd $HOME/.config/
