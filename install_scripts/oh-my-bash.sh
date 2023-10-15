#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo 'source "$HOME"/.aliases' >> $HOME/.bashrc
printf '\nexport PATH=$PATH:/usr/local/bin/kitty.app/bin\n' >> $HOME/.profile
sed -i 's/OSH_THEME="font"/OSH_THEME="minimal-gh"/' $HOME/.bashrc
