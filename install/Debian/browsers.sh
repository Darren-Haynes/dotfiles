sudo apt install -y chromium

# Install qutebrowser
if [ -d "$HOME/.config/qutebrowser" ]; then
  rm -rf "$HOME/.config/qutebrowser"
fi
ln -s "$HOME/Dotfiles/qutebrowser" "$HOME/.config/"

sudo apt install -y qutebrowser
