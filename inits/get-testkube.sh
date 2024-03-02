#!/bin/bash
if [ -f /usr/local/bin/testkube ]; then
  echo "testkube already installed!"
  exit 1
fi

curl -LO "https://github.com/kubeshop/testkube/releases/download/v1.16.26/testkube_1.16.26_Linux_x86_64.tar.gz"

tar xzf testkube_1.16.26_Linux_x86_64.tar.gz kubectl-testkube

sudo mv kubectl-testkube /usr/local/bin/kubectl-testkube
sudo chmod +x /usr/local/bin/kubectl-testkube
sudo ln -s /usr/local/bin/kubectl-testkube /usr/local/bin/testkube

rm testkube_1.16.26_Linux_x86_64.tar.gz

testkube version
