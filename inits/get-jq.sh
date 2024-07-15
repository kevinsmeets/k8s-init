#!/bin/bash
if [ -f /usr/local/bin/jq ]; then
  echo "jq already installed!"
  exit 1
fi

echo "Installing jq..."

sudo wget -qO /usr/local/bin/jq https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64
sudo chmod a+x /usr/local/bin/jq

jq --version

