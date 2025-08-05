#!/bin/bash
if [ -f /usr/local/bin/kubent ]; then
  echo "kubent already installed!"
  exit 1
fi

echo Installing kubent...

VERSION="0.7.3"

curl -LO "https://github.com/doitintl/kube-no-trouble/releases/download/$VERSION/kubent-$VERSION-linux-amd64.tar.gz"

tar xzf kubent-$VERSION-linux-amd64.tar.gz kubent

sudo install -o root -g root -m 0755 kubent /usr/local/bin/kubent

rm kubent
rm kubent-$VERSION-linux-amd64.tar.gz

kubent --version

