#!/bin/bash
if [ -f /etc/bash_completion.d/kind ]; then
  echo "kind auto completion already installed!"
  exit 1
fi

echo "Installing auto completion for kind..."

sudo apt-get install bash-completion
kind completion bash | sudo tee /etc/bash_completion.d/kind > /dev/null

echo "kind auto completion is installed!"
