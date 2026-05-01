#!/bin/bash
if [ -f /etc/bash_completion.d/cilium ]; then
  echo "cilium auto completion already installed!"
  exit 1
fi

echo "Installing auto completion for cilium..."

sudo apt-get install bash-completion
cilium completion bash | sudo tee /etc/bash_completion.d/cilium > /dev/null

echo "cilium auto completion is installed!"
