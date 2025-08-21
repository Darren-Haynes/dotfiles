set -eu

cd "$HOME/Downloads"
curl -L https://github.com/owenthereal/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz -o ccat
chmod a+rx ccat
sudo mv ccat /opt/
cd "$HOME"
