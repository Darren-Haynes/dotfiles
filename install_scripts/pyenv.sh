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
  curl -fsSL https://pyenv.run | bash
  # set up pyenv .bashrc environment
  printf 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
  printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
  printf 'eval "$(pyenv init - bash)"' >> $HOME/.bashrc

  # Set up pyenv .profile environment
  printf 'Appending pyenv environment to .profile'
  printf 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.profile
  printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.profile
  printf 'eval "$(pyenv init - bash)"' >> $HOME/.profile


  # Set up pyenv .bash_profile environment
  if [[ -f "$HOME/.bash_profile" ]]; then
    printf 'Appending pyenv environment to .bash_profile'
    printf 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bash_profile
    printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bash_profile
    printf 'eval "$(pyenv init - bash)"' >> $HOME/.bash_profile
  else
    printf "No bash_profile file - skipping adding pyenv environment to bash_profile"
  fi

  # Set up pyenv .bash_login environment
  if [[ -f "$HOME/.bash_login" ]]; then
    printf 'Appending pyenv environment to .bash_login'
    printf 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bash_login
    printf '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bash_login
    printf 'eval "$(pyenv init - bash)"' >> $HOME/.bash_login
  else
    printf "No bash_login file - skipping adding pyenv environment to bash_login"
  fi

else
  printf 'Pyenv already installed. Skipping...'
fi

exec "$SHELL"
pyenv install 3
pyenv global 3
exec "$SHELL"
