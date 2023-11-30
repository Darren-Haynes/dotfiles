#!/bin/bash

# Install python build dependencies fir pyenv
sudo apt-get install -y \
  build-essential \ 
  libssl-dev zlib1g-dev \
  libbz2-dev \ 
  libreadline-dev \ 
  libsqlite3-dev curl \
  libncursesw5-dev \
  xz-utils \
  tk-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libffi-dev \
  liblzma-dev

# Install pyenv
if [ ! -d "$HOME/.pyenv" ]; then 
  echo 'Installing pyenv to $HOME/.pyenv/'
  curl https://pyenv.run | bash
  # set up pyenv .bashrc environment
  echo 'Appending pyenv environment to .bashrc'
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc

  # Set up pyenv .profile environment
  echo 'Appending pyenv environment to .profile'
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
  echo 'eval "$(pyenv init -)"' >> ~/.profile

  # Set up pyenv .bash_profile environment
  if [[ -f "$HOME/.bash_profile" ]]; then
    echo 'Appending pyenv environment to .bash_profile'
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
  else
    echo "No bash_profile file - skipping adding pyenv environment to bash_profile"
  fi

  # Set up pyenv .bash_login environment
  if [[ -f "$HOME/.bash_login" ]]; then
    echo 'Appending pyenv environment to .bash_login'
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_login
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_login
    echo 'eval "$(pyenv init -)"' >> ~/.bash_login
  else
    echo "No bash_login file - skipping adding pyenv environment to bash_login"
  fi

else
  echo 'Pyenv already installed. Skipping...'
fi

exec "$SHELL"
pyenv install 3.12.0
pyenv global 3.12.0
exec "$SHELL"
python3 -m pip install --user --upgrade pynvim
pyenv virtualenv 3.12.0 py3neovim
pyenv activate py3neovim
python3 -m pip install pynvim
