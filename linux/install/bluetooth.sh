#!/bin/bash

set -eu

# Install and enable bluetooth
sudo apt-get install -y bluez
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Install terminal bluetooth manager tool. Rust and cargo must be installed first.

sudo apt-get install -y libdbus-1-dev
sudo apt-get install -y pkg-config
cargo install bluetui
