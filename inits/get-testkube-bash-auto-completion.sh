#!/bin/bash
if [ -f /etc/bash_completion.d/testkube ]; then
  echo "testkube auto completion already installed!"
  exit 1
fi

sudo apt-get install bash-completion
testkube completion bash | sudo tee /etc/bash_completion.d/testkube > /dev/null

echo "testkube auto completion is installed!"
