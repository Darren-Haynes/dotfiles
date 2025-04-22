sudo apt install -y rofi	       # application launcher and switcher
ln -s $HOME/Dotfiles/rofi/config.rasi $HOME/.config/rofi/
mkdir $HOME/Downloads
curl https://raw.githubusercontent.com/w8ste/Tokyonight-rofi-theme/refs/heads/main/tokyonight_big2.rasi > $HOME/Downloads/tokyonight.rasi
sudo mv $HOME/Downloads/tokyonight.rasi /usr/share/rofi/themes

