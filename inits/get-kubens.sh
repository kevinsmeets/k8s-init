#!/bin/bash
if [ -f /usr/local/bin/kubens ]; then
  echo "kubens already installed!"
  exit 1
fi

echo Installing kubens...

curl -LO "https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubens"

sudo install -o root -g root -m 0755 kubens /usr/local/bin/kubens

rm kubens

kubens --help
