# Install fonts
sudo apt install \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \
  dtrx

fonts_dir="$HOME/.fonts"
if [ ! -d "$fonts_dir" ]; then
  mkdir "$fonts_dir"
  # chown -R $USER:$(id -g -n $USER) "fonts_dir"
  echo "~/.fonts dir created."
  else
    echo "Skip making ~/.fonts dir, it already exists"
fi

spacemono_dir="$HOME/.fonts/SpaceMono/"
if [ ! -d "$spacemono_dir" ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip -P "$spacemono_dir"
  # chown -R $USER:$(id -g -n $USER) "$spacemono_dir"
  dtrx "$spacemono_dir"/SpaceMono.zip
  fc-cache -fv
  rm "$spacemono_dir"/SpaceMono.zip
  echo "SpaceMono font installed to ~/.fonts/SpaceMono"
  cd
  else
    echo "SpaceMono font already installed"
fi
