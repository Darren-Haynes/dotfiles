#!/bin/bash

# Link config file before install. Otherwise install will be you to the create of the dir

#!/bin/bash

if [ ! -d "$HOME/.config/rofi" ]; then 
    mkdir $HOME/.config/rofi
    ln -s $HOME/Dotfiles/rofi/config.rasi $HOME/.config/rofi/
fi

sudo apt install -y rofi	       # application launcher and switcher

# Install tokyonight rofi theme
mkdir $HOME/Downloads
curl https://raw.githubusercontent.com/w8ste/Tokyonight-rofi-theme/refs/heads/main/tokyonight_big2.rasi > $HOME/Downloads/tokyonight.rasi
sudo mv $HOME/Downloads/tokyonight.rasi /usr/share/rofi/themes

