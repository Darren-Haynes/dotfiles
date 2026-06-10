sudo apt-get install -y gnome-keyring

cd "$HOME/Downloads" || exit
curl -o vscode.deb https://vscode.download.prss.microsoft.com/dbazure/download/stable/19e0f9e681ecb8e5c09d8784acaa601316ca4571/code_1.100.0-1746623151_amd64.deb
sudo dpkg -i vscode.deb
rm vscode.deb
cd "$HOME"
