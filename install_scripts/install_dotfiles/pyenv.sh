#!/bin/bash

#FIGURE OUT HOW TO RUN "pyenv 2.7.15" etc from this shell script."
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)/plugins/pyenv-virtualenv"
