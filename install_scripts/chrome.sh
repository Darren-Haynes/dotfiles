#!/bin/bash

sudo apt install -y \
    fonts-liberation \
    libasound2 \
    libu2f-udev \
    xdg-utils \

os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/tmp
working_dir=$HOME/tmp
if [[ "$os" = "ID=debian" ]]; then
    echo "Installing Chrome for Debian"
    url=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    wget -P $working_dir $url
    sudo dpkg -i "$working_dir/google-chrome-stable_current_amd64.deb"
    rm -rf $working_dir
    echo "$(google-chrome --version) has been installed"
fi
