#!/bin/bash

if [ ! -d "$HOME/.config" ]; then 
    mkdir $HOME/.config
fi

ln -s $HOME/Dotfiles/aliases $HOME/.aliases
ln -s $HOME/Dotfiles/X/xinitrc $HOME/.xinitrc
ln -s $HOME/Dotfiles/X/Xresources $HOME/.Xresources
