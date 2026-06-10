#!/bin/bash

# Link config file before install. Otherwise install will be you to the create of the dir

#!/bin/bash

if [ ! -d "$HOME/.config/rofi" ]; then
  mkdir "$HOME/.config/rofi"
  ln -s "$HOME/Dotfiles/rofi/config.rasi" "$HOME/.config/rofi/"
  ln -s "$HOME/Dotfiles/rofi/nord.rasi" "$HOME/.config/rofi/"
fi

sudo apt install -y rofi # application launcher and switcher
