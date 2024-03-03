#!/bin/bash
if ! [ -f /etc/bash_completion.d/kubectl ]; then
  echo "kubectl auto completion must be installed first!"
  exit 1
fi

if grep -q "k=kubectl" ~/.bashrc; then
  echo "kubectl alias 'k' already setup!"
  exit 1
fi

echo "Installing kubectl alias 'k'..."

{
	# My alias for kubectl
	echo alias k=kubectl
	echo complete -o default -F __start_kubectl k
} >> ~/.bashrc

echo "kubectl alias 'k' has been setup with auto completion enabled!"
