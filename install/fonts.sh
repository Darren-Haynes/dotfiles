# Install Nerdy Fonts

set -eu

sudo apt install -y fonts-powerline
sudo apt install -y fonts-font-awesome

ShureMono=$(fc-list : family | grep "ShureTechMono Nerd Font Mono")
if [ "$ShureMono" = "ShureTechMono Nerd Font Mono" ]; then
  echo "Skipping - ShureTechMono font already installed."
else
  ShureTechDir="$HOME/.local/share/fonts/ShureTechMono"
  mkdir -p "$ShureTechDir"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/ShareTechMono.tar.xz -P "$ShureTechDir"
  tar -xf "$ShureTechDir/ShareTechMono.tar.xz" -C "$ShureTechDir"
  rm "$ShureTechDir/ShareTechMono.tar.xz"
  fc-cache -fv
  echo "ShureTechMono font installed to $ShureTechDir"
fi

SpaceMono=$(fc-list : family | grep "SpaceMono Nerd Font Mono")
if [ "$SpaceMono" = "SpaceMono Nerd Font Mono" ]; then
  echo "Skipping - SpaceMono font already installed."
else
  SpaceMonoDir="$HOME/.local/share/fonts/SpaceMonoDir"
  mkdir -p "$SpaceMonoDir"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/ShareTechMono.tar.xz -P "$SpaceMonoDir"
  tar -xf "$SpaceMonoDir/ShareTechMono.tar.xz" -C "$SpaceMonoDir"
  rm "$SpaceMonoDir/ShareTechMono.tar.xz"
  fc-cache -fv
  echo "ShureTechMono font installed to $SpaceMonoDir"
fi

FiraCode=$(fc-list : family | grep "FiraCode Nerd Font Mono")
if [ "$FiraCode" = "FiraCode Nerd Font Mono" ]; then
  echo "Skipping - FiraCode font already installed."
else
  FiraCodeDir="$HOME/.local/share/fonts/FiraCodeDir"
  mkdir -p "$FiraCodeDir"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.tar.xz
  tar -xf "$FiraCodeDir/ShareTechMono.tar.xz" -C "$FiraCodeDir"
  rm "$FiraCodeDir/ShareTechMono.tar.xz"
  fc-cache -fv
fi
