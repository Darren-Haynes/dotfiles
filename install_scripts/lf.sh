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
    echo "LF version $(lf --version) has been installed to /usr/local/bin"
    ln -s $HOME/Dotfiles/lf $HOME/.config/

    # Install cptv for images previews in LF.
    sudo apt-get install -y \
	libmagic-dev \
	libssl-dev \
	build-essential \
	bat \ # syntax highlighting
	file \
	w3m \ # html highlighting
	poppler-utils # pdf preview

    mkdir $HOME/GitClones
    cd $HOME/GitClones
    git clone https://github.com/NikitaIvanovV/ctpv
    cd ctpv
    make
    sudo make install
    cd $HOME
    ln -s $HOME/Dotfiles/cptv $HOME/.config/
    echo "CPTV installed for LF previews."
     
fi


