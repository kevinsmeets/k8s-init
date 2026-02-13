#!/bin/bash
if [ -f /usr/local/bin/dive ]; then
  echo "dive already installed!"
  exit 1
fi

echo Installing dive...

VERSION="0.13.1"
ARCHIVE=dive_"$VERSION"_linux_amd64.tar.gz
URL=https://github.com/wagoodman/dive/releases/download/v"$VERSION"/"$ARCHIVE"

curl -LO "$URL"

tar -xzf "$ARCHIVE" dive
rm "$ARCHIVE"

chmod +x dive

sudo mv dive /usr/local/bin/

dive version

