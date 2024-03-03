#!/bin/bash
if [ -f /etc/bash_completion.d/testkube ]; then
  echo "testkube auto completion already installed!"
  exit 1
fi

echo "Installing auto completion for testkube..."

sudo apt-get install bash-completion
testkube completion bash | sudo tee /etc/bash_completion.d/testkube > /dev/null

echo "testkube auto completion is installed!"
