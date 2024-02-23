#!/bin/bash
if [ -f /usr/local/bin/kubeconform ]; then
  echo "kubeconform already installed!"
  exit 1
fi

curl -LO "https://github.com/yannh/kubeconform/releases/download/v0.6.4/kubeconform-linux-amd64.tar.gz"

tar xzf kubeconform-linux-amd64.tar.gz

sudo install -o root -g root -m 0755 kubeconform /usr/local/bin/kubeconform

rm kubeconform
rm kubeconform-linux-amd64.tar.gz

kubeconform -v
