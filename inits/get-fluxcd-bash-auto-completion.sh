#!/bin/bash
if [ -f /etc/bash_completion.d/flux ]; then
  echo "flux auto completion already installed!"
  exit 1
fi

echo "Installing auto completion for flux..."

sudo apt-get install bash-completion
flux completion bash | sudo tee /etc/bash_completion.d/flux > /dev/null

echo "flux auto completion is installed!"
