#!/bin/bash

if [ ! -d "$HOME/.config" ]; then 
    mkdir $HOME/.config
fi

ln -s $HOME/Dotfiles/aliases $HOME/.aliases

