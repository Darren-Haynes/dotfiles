#!/bin/bash

sudo apt install -y lpr
sudo apt install -y cups

# naps2 - the only way to scan
cd "$HOME/Downloads" || exit
sudo deb -i naps.deb https://github.com/cyanfish/naps2/releases/download/v8.1.4/naps2-8.1.4-linux-x64.deb
rm naps.deb
cd "$HOME" || exit
