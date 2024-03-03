#!/bin/bash
if [ -f /usr/local/bin/helm ]; then
  echo "helm already installed!"
  exit 1
fi

echo "Ïnstalling helm..."

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash

helm version
