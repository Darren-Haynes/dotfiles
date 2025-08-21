#!/bin/bash

set -eu

if [ ! -d "$HOME/.config/Speedcrunch" ]; then
  mkdir "$HOME/.config/Speedcrunch"
  ln -s "$HOME/Dotfiles/SpeedCrunch/SpeedCrunch.ini" "$HOME/.config/Speedcrunch/"
fi

cd "$HOME/Downloads" || exit
curl -o speedcrunch.deb https://bitbucket.org/heldercorreia/speedcrunch/downloads/SpeedCrunch-0.12-linux32.deb
sudo dpkg -i speedcrunch.deb
rm speedcrunch.deb
cd "$HOME"
