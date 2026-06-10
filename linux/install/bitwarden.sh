#!/bin/bash

set -eu

cd "$HOME/Downloads" || exit
curl -o bitwarden.deb https://bitwarden.com/download/?app=desktop\&platform=linux\&variant=deb
sudo dpkg -i bitwarden.deb
rm bitwarden.deb
cd "$HOME"
