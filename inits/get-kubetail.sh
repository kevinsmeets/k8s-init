#!/bin/bash
if [ -f /usr/local/bin/kubetail ]; then
  echo "kubetail already installed!"
  exit 1
fi

echo Installing kubetail...

curl -LO "https://raw.githubusercontent.com/johanhaleby/kubetail/master/kubetail"

chmod +x kubetail

sudo mv kubetail /usr/local/bin/kubetail

kubetail --version

