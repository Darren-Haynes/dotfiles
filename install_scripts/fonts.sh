# Install fonts
sudo yes Y | apt install \
  xfonts-100dpi \
  xfonts-75dpi \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \
  dtrx

fonts_dir="$HOME/.fonts"
if [ ! -d "$fonts_dir" ]; then
  mkdir "$HOME/.fonts"
  else
    echo ".fonts dir already exists"
fi

spacemono_dir="$HOME/.fonts/SpaceMono/"
if [ ! -d "$spacemono_dir" ]; then
  cd "$HOME/.fonts"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip
  dtrx SpaceMono.zip
  fc-cache -fv
  rm SpaceMono.zip
  cd
  else
    echo "SpaceMono font already installed"
fi
