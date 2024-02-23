#!/bin/bash
if ! [[ $(grep -q bash-completion) ]]; then
  echo "Package bash-completion is not installed! Running apt-get..."
  sudo apt-get install bash-completion
else
  echo "Package bash-completion is installed."
fi

if [ -f /etc/bash_completion.d/kubectl ]; then
  echo "kubectl auto completion already installed!"
  exit 1
fi

kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null

echo "kubectl auto completion is installed!"
