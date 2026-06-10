# Install qutebrowser
if [ -d "$HOME/.config/qutebrowser" ]; then
  rm -rf "$HOME/.config/qutebrowser"
fi
ln -s "$HOME/Dotfiles/qutebrowser" "$HOME/.config/"
