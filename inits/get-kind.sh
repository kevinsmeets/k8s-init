#!/bin/bash
if [ -f /usr/local/bin/kind ]; then
	echo "kind is already installed!"
	exit 1
fi

kind_version="0.21.0"

curl -Lo ./kind-linux-amd64 https://github.com/kubernetes-sigs/kind/releases/download/v$kind_version/kind-linux-amd64

chmod +x ./kind-linux-amd64
sudo mv ./kind-linux-amd64 /usr/local/bin/kind
kind version
