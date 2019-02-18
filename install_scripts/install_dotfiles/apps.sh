#!/bin/bash

sudo yes Y | apt install firefox
echo 'Firefox installed'

# Install ranger and cp config files to user
sudo yes Y | apt install ranger
ranger --copy-config=all
echo 'Ranger installed and configs copied to ~/.config/ranger/'
