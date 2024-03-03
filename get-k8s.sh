#!/bin/bash

echo "Checking if docker is installed.."
if ! docker_loc="$(type -p "docker")" || [[ -z $docker_loc ]]; then
  echo "No docker on this system!"
  exit 1
fi

echo "This system has docker!"
docker --version

echo
echo "Create k8s environment..."

inits/get-kind.sh
inits/get-kubectl.sh
inits/get-kubectl-bash-auto-completion.sh
inits/get-kubectl-bash-alias.sh
inits/get-tmux.sh
inits/get-yq.sh
inits/get-kubeconform.sh
inits/get-helm.sh
inits/get-helm-bash-auto-completion.sh
inits/get-fluxcd.sh
inits/get-k9s.sh

kind/create-cluster.sh k8s

inits/get-fluxcd-in-kubernetes.sh
inits/get-testkube.sh
inits/get-testkube-bash-auto-completion.sh
inits/get-kubernetes-metrics-server.sh
inits/get-kubernetes-dashboard.sh
