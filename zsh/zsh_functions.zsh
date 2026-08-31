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
