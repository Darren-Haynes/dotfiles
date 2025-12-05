#!/bin/bash

# Pyenv inital set-up
pyenv install 3
pyenv global 3
pyenv install 3.12
pyenv install 3.13.3
mkdir -p $HOME/Code/Python/{Playground_3.12,Playground_3.13}
pyenv virtualenv 3.12 playground_3.12
pyenv virtualenv 3.13 playground_3.13
exec "$SHELL"
