#!/bin/bash
if [ -f /etc/bash_completion.d/helm ]; then
  echo "helm auto completion already installed!"
  exit 1
fi

sudo apt-get install bash-completion
helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null

echo "helm auto completion is installed!"
