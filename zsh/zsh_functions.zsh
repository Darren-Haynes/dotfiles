# zsh_functions.zsh
# Custom zsh functions sourced from .zshrc
#
# touch - enhanced touch that auto-creates parent directories
# Overwrites the system `touch`. If the parent directory of a target
# file doesn't exist, it creates the full directory path (like `mkdir -p`)
# before touching the file. If the directory already exists, it behaves
# exactly like the regular `touch`.
#
# Usage:
#   touch src/CloudGuard.Client/src/test/setup.ts
#   # Creates src/CloudGuard.Client/src/test/ if needed, then touches the file.

touch() {
  for f in "$@"; do
    [[ -d $f:h ]] || mkdir -p -- "$f:h"
  done
  command touch -- "$@"
}

# gnome-keybinds - list or grep keybindings for GNOME
# Usage:
#   gnome-keybinds <search-term>
#   gnome-keybinds
gnome-keybinds() {
  local schemas=(
    org.gnome.shell.keybindings
    org.gnome.desktop.wm.keybindings
    org.gnome.mutter.keybindings
    org.gnome.mutter.wayland.keybindings
    org.gnome.settings-daemon.plugins.media-keys
  )

  # If an argument is given, grep across all schemas
  if [[ -n "$1" ]]; then
    for s in "${schemas[@]}"; do
      gsettings list-recursively "$s" | grep -i --color "$1"
    done
  else
    for s in "${schemas[@]}"; do
      echo "=== $s ==="
      gsettings list-recursively "$s"
    done
  fi
}
