#!/bin/bash

function install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

function update_profiles() {
  printf 'source "$HOME"/.aliases' >>$HOME/.bashrc
  sed -i 's/OSH_THEME="font"/OSH_THEME="bobby-python"/' $HOME/.bashrc
  printf '# Bash vim mode' >>$HOME/.bashrc
  printf 'set -o vi' >>$HOME/.bashrc
  printf '# Bash vim mode' >>$HOME/.profile
  printf 'set -o vi' >>$HOME/.profile
}

install &
wait
update_profiles
