# Install fonts
sudo yes Y | apt install \
  xfonts-100dpi \
  xfonts-75dpi \
  fonts-dejavu \
  ttf-dejavu \
  fonts-powerline \
  fonts-font-awesome \

mkdir "$HOME/.fonts"
cd "$HOME/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/SpaceMono.zip
sudo yes Y | apt install dtrx
dtrx SpaceMono.zip
fc-cache -fv
rm SpaceMono.zip
cd
