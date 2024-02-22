#!/bin/bash
if [ -f /usr/local/bin/kind ]; then
	echo "kind is already installed!"
	exit 1
fi

curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.21.0/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin
kind version
