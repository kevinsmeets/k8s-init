#!/bin/bash
if [ -f /usr/local/bin/lazydocker ]; then
  echo "lazydocker already installed!"
  exit 1
fi

echo Installing lazydocker...

VERSION="0.24.4"
ARCHIVE=lazydocker_"$VERSION"_Linux_x86_64.tar.gz
URL=https://github.com/jesseduffield/lazydocker/releases/download/v"$VERSION"/"$ARCHIVE"

curl -LO "$URL"

tar -xzf "$ARCHIVE" lazydocker
rm "$ARCHIVE"

chmod +x lazydocker

sudo mv lazydocker /usr/local/bin/

lazydocker version

