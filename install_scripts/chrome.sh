#!/bin/bash

sudo apt install -y fonts-liberation
sudo apt install -y libasound2
sudo apt install -y libu2f-udev
sudo apt install -y xdg-utils

os=$(grep -E ^ID= /etc/os-release)

mkdir "$HOME/tmp"
tempDir=$HOME/tmp
if [[ "$os" = "ID=debian" ]]; then
  echo "Installing Chrome for Debian"
  url=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  wget -P $tempDir $url
  sudo dpkg -i "$tempDir/google-chrome-stable_current_amd64.deb"
  rm -rf $tempDir
  echo "$(google-chrome --version) has been installed"
fi
