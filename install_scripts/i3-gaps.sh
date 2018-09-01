#!/bin/bash

#i3 Gaps
sudo yes Y | apt install \
    libxcb-keysyms1-dev \
    libyajl-dev \
    linstartup-notification0-dev \
    libev-dev \
    libxcb-xinerama0-dev \
    libxcbcommon-x11-dev

cd
git clone https://www.github.com/Airblader/i3
cd i3
autreconf --force --install
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
cd
rm -rf i3
