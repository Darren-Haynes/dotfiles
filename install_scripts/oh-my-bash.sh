#!/bin/bash

function install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

function update_profiles() {
  printf 'source "$HOME"/.aliases' >>$HOME/.bashrc
  sed -i 's/OSH_THEME="font"/OSH_THEME="bobby-python"/' $HOME/.bashrc
}

install &
wait
update_profiles
