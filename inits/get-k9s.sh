#!/bin/bash
if [ -f /usr/local/bin/k9s ]; then
  echo "k9s already installed!"
  exit 1
fi

k9s_version="0.31.9"

curl -LO "https://github.com/derailed/k9s/releases/download/v$k9s_version/k9s_Linux_amd64.tar.gz"

tar xzf k9s_Linux_amd64.tar.gz k9s

sudo mv k9s /usr/local/bin/
sudo chmod +x /usr/local/bin/k9s

rm k9s_Linux_amd64.tar.gz

k9s version
