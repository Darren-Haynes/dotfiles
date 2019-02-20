# Install fonts
sudo apt install \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \
  dtrx

space=$(fc-list : family | grep "SpaceMono Nerd Font Mono")

if [$space == "SpaceMono Nerd Font Mono"]; then
    echo "Skipping - SpaceMono font already installed."
    exit 1
fi

# In case any fonts haven't been installed
fc-cache -fv

spacemono_dir="$HOME/.local/share/fonts/SpaceMono"
if [ ! -d "$spacemono_dir" ]; then
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip -P "$spacemono_dir"
    cd "$spacemono_dir"
    dtrx SpaceMono.zip
    fc-cache -fv
    rm SpaceMono.zip
    cd
    echo "SpaceMono font installed to $spacemono_dir"

    else
        echo "Skipping - SpaceMono font already installed"
fi

