#!/bin/bash

# Install and configure Neovim
os=$(grep -E ^ID= /etc/os-release)

mkdir $HOME/tmp
working_dir=$HOME/tmp
if [[ "$os" = "ID=debian" ]]; then
    echo "Installing LF"
    url=https://github.com/gokcehan/lf/releases/download/r31/lf-linux-amd64.tar.gz
    wget -P $working_dir $url
    tar -xf "$working_dir/lf-linux-amd64.tar.gz" -C $working_dir
    sudo mv "$working_dir/lf" /usr/local/bin/
    rm -rf $working_dir
    echo "LF version $(lf --version) has been installed to /usr/local/bin"
fi


