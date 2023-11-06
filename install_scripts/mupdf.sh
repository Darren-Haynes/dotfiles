#!/bin/bash

sudo apt-get install -y \
    mupdf

origF=$HOME/.local/share/applications/mimeapps.list
targetF=$HOME/Dotfiles/mupdf/mimeapps.list
appDir=$HOME/.local/share/applications/

if [ ! -d $appDir ]; then 
    mkdir $HOME/.local/share/applications/
fi

if [ -f $origF ] || [ ! -e $origF ]; then
    rm $origF
    ln -s $targetF $origF
    printf "MUPDF CONFIG FILELINK CREATED:\n"
    printf "$(ls -l $appDir | grep mimeapps)"
    printf "\n"
fi

