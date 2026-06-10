# Install Nerdy Fonts

set -eu

sudo apt install -y fonts-powerline
sudo apt install -y fonts-font-awesome

ShureTechDir="$HOME/.local/share/fonts/ShureTechMono"
mkdir -p "$ShureTechDir"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/ShareTechMono.tar.xz -P "$ShureTechDir"
tar -xf "$ShureTechDir/ShareTechMono.tar.xz" -C "$ShureTechDir"
rm "$ShureTechDir/ShareTechMono.tar.xz"

SpaceMonoDir="$HOME/.local/share/fonts/SpaceMonoDir"
mkdir -p "$SpaceMonoDir"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SpaceMono.tar.xz -P "$SpaceMonoDir"
tar -xf "$SpaceMonoDir/SpaceMono.tar.xz" -C "$SpaceMonoDir"
rm "$SpaceMonoDir/SpaceMono.tar.xz"

FiraCodeDir="$HOME/.local/share/fonts/FiraCodeDir"
mkdir -p "$FiraCodeDir"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.tar.xz
tar -xf "$FiraCodeDir/FiraCode.tar.xz" -C "$FiraCodeDir"
rm "$FiraCodeDir/FiraCode.tar.xz"

fc-cache -fv
