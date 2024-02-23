#!/bin/bash
if [ -f /usr/local/bin/yq ]; then
  echo "yq already installed!"
  exit 1
fi

sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod a+x /usr/local/bin/yq

yq --version
