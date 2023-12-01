#!/bin/bash

# Install python build dependencies for pyenv
sudo apt-get install -y build-essential  
sudo apt-get install -y libssl-dev zlib1g-dev 
sudo apt-get install -y libbz2-dev  
sudo apt-get install -y libreadline-dev  
sudo apt-get install -y libsqlite3-dev curl 
sudo apt-get install -y libncursesw5-dev 
sudo apt-get install -y xz-utils 
sudo apt-get install -y tk-dev 
sudo apt-get install -y libxml2-dev 
sudo apt-get install -y libxmlsec1-dev 
sudo apt-get install -y libffi-dev 
sudo apt-get install -y liblzma-dev

# Install pyenv
if [ ! -d "$HOME/.pyenv" ]; then 
  printf 'Installing pyenv to $HOME/.pyenv/'
  curl https://pyenv.run | bash
  # set up pyenv .bashrc environment
  printf 'Appending pyenv environment to .bashrc'
  printf 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  printf 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  printf 'eval "$(pyenv init -)"' >> ~/.bashrc

  # Set up pyenv .profile environment
  printf 'Appending pyenv environment to .profile'
  printf 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
  printf 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
  printf 'eval "$(pyenv init -)"' >> ~/.profile

  # Set up pyenv .bash_profile environment
  if [[ -f "$HOME/.bash_profile" ]]; then
    printf 'Appending pyenv environment to .bash_profile'
    printf 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    printf 'eval "$(pyenv init -)"' >> ~/.bash_profile
  else
    printf "No bash_profile file - skipping adding pyenv environment to bash_profile"
  fi

  # Set up pyenv .bash_login environment
  if [[ -f "$HOME/.bash_login" ]]; then
    printf 'Appending pyenv environment to .bash_login'
    printf 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_login
    printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_login
    printf 'eval "$(pyenv init -)"' >> ~/.bash_login
  else
    printf "No bash_login file - skipping adding pyenv environment to bash_login"
  fi

else
  printf 'Pyenv already installed. Skipping...'
fi

exec "$SHELL"
pyenv install 3.12.0
pyenv global 3.12.0
exec "$SHELL"
python3 -m pip install --user --upgrade pynvim
pyenv virtualenv 3.12.0 py3neovim
pyenv activate py3neovim
python3 -m pip install pynvim
