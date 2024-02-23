#!/bin/bash
if [ -f /usr/local/bin/kubectl ]; then
  echo "kubectl already installed!"
  exit 1
fi

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm kubectl

kubectl version --client
