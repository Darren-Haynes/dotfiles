#!/bin/bash

set -eu

# Download and install Oracle Jave 21
cd "$HOME/Downloads/"
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
sudo dpkg -i jdk-21_linux-x64_bin.deb -y
rm jdk-21_linux-x64_bin.deb

# set up environment variables
sudo sh -c 'echo "/usr/lib/jvm/jdk-21-oracle-x64" >>/file.txt'
sudo sh -c 'echo "$PATH:${JAVA_HOME}/bin" >>/file.txt'
source /etc/environment

#Install clojure
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
chmod +x linux-install.sh
sudo ./linux-install.sh
rm linx-install.sh
