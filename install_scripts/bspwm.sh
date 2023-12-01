#!/bin/bash

sudo apt-get install bspwm -y
sudo apt-get installsxhkd -y               			# bspwm keyboard interface
sudo apt-get installlibxcb-xkb1 -y         			# x keyboard controller
sudo apt-get installfeh -y                 			# manage wallpaper
sudo apt-get installpm-utils -y            			# power management utils
sudo apt-get installupower -y              			# freedesktop power management
sudo apt-get installxfce4-power-manager -y 			# power manager
sudo apt-get installxfconf -y              			# xfce settings
sudo apt-get installlxappearance -y        			# theme management
sudo apt-get installgtk2-engines-murrine -y			# glass purdy
sudo apt-get installlibnotify4 -y          			# desktop notifications
sudo apt-get installpulseaudio -y             	# audio

ln -s $HOME/Dotfiles/bspwm $HOME/.config/
ln -s $HOME/Dotfiles/sxhkd $HOME/.config/

