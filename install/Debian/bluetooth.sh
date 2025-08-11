#!/bin/bash

set -eu

# Install and enable bluetooth
sudo apt-get install bluez
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Install terminal bluetooth manager tool. Rust and cargo must be installed first.
cargo install bluetui
