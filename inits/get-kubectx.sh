#!/bin/bash
if [ -f /usr/local/bin/kubectx ]; then
  echo "kubectx already installed!"
  exit 1
fi

echo Installing kubectx...

curl -LO "https://github.com/ahmetb/kubectx/releases/download/v0.9.5/kubectx"

sudo install -o root -g root -m 0755 kubectx /usr/local/bin/kubectx

rm kubectx

kubectx --help
