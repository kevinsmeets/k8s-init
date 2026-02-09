#!/bin/bash
if [ -f /usr/local/bin/ktop ]; then
  echo "ktop already installed!"
  exit 1
fi

echo Installing ktop...

VERSION="0.5.3"
ARCHIVE=ktop_v"$VERSION"_linux_amd64.tar.gz
URL=https://github.com/vladimirvivien/ktop/releases/download/v"$VERSION"/"$ARCHIVE"


echo "$URL"

curl -LO "$URL"

tar -xzf "$ARCHIVE" ktop
rm "$ARCHIVE"

chmod +x ktop

sudo mv ktop /usr/local/bin/

ktop version

