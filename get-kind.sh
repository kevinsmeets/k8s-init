#!/bin/bash
if [ -f /usr/local/bin/kind ]; then
	echo "kind is already installed!"
	exit 1
fi

kind_version="0.21.0"

curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v$kind_version/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin
kind version
