#!/bin/bash
if ! [ -f /usr/local/bin/flux ]; then
  echo "flux is not installed!"
  exit 1
fi

flux install

flux --version
