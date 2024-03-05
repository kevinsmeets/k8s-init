#!/bin/bash
if [ -f /etc/flux_completion.d/kubectl ]; then
  echo "flux auto completion already installed!"
  exit 1
fi

echo "Installing auto completion for flux."

sudo apt-get install bash-completion
flux completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null

echo "flux auto completion is installed!"
