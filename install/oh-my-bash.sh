#!/bin/bash

set -eu

function install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

function update_profiles() {
  printf "source %s/.aliases\n" "$HOME" >>"$HOME/.bashrc"
  sed -i 's/OSH_THEME="font"/OSH_THEME="bobby-python"/' "$HOME/.bashrc"
  printf 'set -o vi\n' >>"$HOME/.bashrc"
  printf 'set -o vi\n' >>"$HOME/.profile"
}

install &
wait
update_profiles
