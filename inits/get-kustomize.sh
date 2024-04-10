#!/bin/bash
if [ -f /usr/local/bin/kustomize ]; then
  echo "kustomize already installed!"
  exit 1
fi

kustomize_version="5.4.1"

echo Installing kustomize...

curl -Lo kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v"$kustomize_version"/kustomize_v"$kustomize_version"_linux_amd64.tar.gz

tar -xzf kustomize.tar.gz
chmod +x kustomize
sudo mv ./kustomize /usr/local/bin/

rm kustomize.tar.gz

kustomize version
