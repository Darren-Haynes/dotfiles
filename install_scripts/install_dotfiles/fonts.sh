# Install fonts
sudo apt install \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \
  dtrx

# fonts_dir="$HOME/.fonts"
# if [ ! -d "$fonts_dir" ]; then
  # mkdir "$fonts_dir"
  # chown -R $USER:$(id -g -n $USER) "fonts_dir"
  # echo "~/.fonts dir created."
  # else
    # echo "Skip making ~/.fonts dir, it already exists"
# fi

fonts_dir="$HOME/.local/share/fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip -P "$fonts_dir"
cd "$fonts_dir"
dtrx SpaceMono.zip
fc-cache -fv
rm SpaceMono.zip
cd
echo "SpaceMono font installed to $fonts_dir"
