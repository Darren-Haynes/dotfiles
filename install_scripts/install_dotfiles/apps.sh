#!/bin/bash

sudo apt install fonts-lyx

os=$(grep -E ^ID= /etc/os-release)

if [[ "$os" = "ID=elementary" || "$os" == "ID=ubuntu" ]]; then
    echo "Ubuntu base operating system detected - installing firefox"
    sudo apt install firefox
fi

if [[ "$os" = "ID=debian" ]]; then
    echo "Debian base operating system detected - installing firefox-esr"
    sudo apt install firefox-esr
fi


echo 'Installing Pyenv'
# Pyenv dependencies
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
