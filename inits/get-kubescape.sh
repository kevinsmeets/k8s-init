#!/bin/bash
if [ -f /usr/local/bin/kubescape ]; then
  echo "kubescape already installed!"
  exit 1
fi

echo Installing kubescape...

VERSION="4.0.0"
ARCHIVE=kubescape_"$VERSION"_linux_amd64.tar.gz
URL=https://github.com/kubescape/kubescape/releases/download/v"$VERSION"/"$ARCHIVE"


echo "$URL"

curl -LO "$URL"

tar -xzf "$ARCHIVE" kubescape
rm "$ARCHIVE"

chmod +x kubescape

sudo mv kubescape /usr/local/bin/

kubescape version

