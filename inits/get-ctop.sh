#!/bin/bash
if [ -f /usr/local/bin/ctop ]; then
  echo "ctop already installed!"
  exit 1
fi

echo Installing ctop...

VERSION="0.7.7"
BIN=ctop-"$VERSION"-linux-amd64
URL=https://github.com/bcicen/ctop/releases/download/v"$VERSION"/"$BIN"

curl -LO "$URL"

chmod +x $BIN

sudo mv $BIN /usr/local/bin/ctop

ctop -v

