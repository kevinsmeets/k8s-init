#!/bin/bash
if [ -f /etc/bash_completion.d/kubectl ]; then
  echo "kubectl auto completion already installed!"
  exit 1
fi

sudo apt-get install bash-completion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null

echo "kubectl auto completion is installed!"
