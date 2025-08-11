set -eu

cd "$HOME/Downloads"
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o yt-dlp
chmod a+rx yt-dlp
sudo mv yt-dlp /opt/
cd "$HOME"
