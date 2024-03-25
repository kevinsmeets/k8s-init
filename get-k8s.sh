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

echo "[INIT]"; inits/get-kind.sh --version 0.22.0
echo "[INIT]"; inits/get-kubectl.sh
echo "[INIT]"; inits/get-kubectl-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubectl-bash-alias.sh
echo "[INIT]"; inits/get-tmux.sh
echo "[INIT]"; inits/get-yq.sh
echo "[INIT]"; inits/get-kubeconform.sh
echo "[INIT]"; inits/get-helm.sh
echo "[INIT]"; inits/get-helm-bash-auto-completion.sh
echo "[INIT]"; inits/get-fluxcd.sh
echo "[INIT]"; inits/get-fluxcd-bash-auto-completion.sh
echo "[INIT]"; inits/get-k9s.sh --version 0.32.4

echo "[INIT]"; kind/create-cluster.sh k8s

echo "[INIT]"; inits/get-fluxcd-in-kubernetes.sh
echo "[INIT]"; inits/get-testkube.sh
echo "[INIT]"; inits/get-testkube-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubernetes-metrics-server.sh
echo "[INIT]"; inits/get-kube-state-metrics.sh
echo "[INIT]"; inits/get-kubernetes-dashboard.sh

