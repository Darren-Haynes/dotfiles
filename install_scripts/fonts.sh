# Install Nerdy Fonts
sudo apt install -y fonts-powerline
sudo apt install -y fonts-font-awesome

ShureMono=$(fc-list : family | grep "ShureTechMono Nerd Font Mono")
if [ "$ShureMono" = "ShureTechMono Nerd Font Mono" ]; then
  echo "Skipping - ShureTechMono font already installed."
  exit 1
fi

ShureTechDir="$HOME/.local/share/fonts/ShureTechMono"
mkdir -p "$ShureTechDir"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/ShareTechMono.tar.xz -P "$ShureTechDir"
tar -xf "$ShureTechDir/ShareTechMono.tar.xz" -C "$ShureTechDir"
rm "$ShureTechDir/ShareTechMono.tar.xz"
fc-cache -fv
echo "ShureTechMono font installed to $ShureTechDir"
