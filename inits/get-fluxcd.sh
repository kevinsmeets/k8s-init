#!/bin/bash
if [ -f /usr/local/bin/flux ]; then
  echo "flux already installed!"
  exit 1
fi

curl -s https://fluxcd.io/install.sh | sudo bash

flux version
