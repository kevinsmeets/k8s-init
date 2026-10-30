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

echo "[INIT]"; inits/get-kind.sh --version 0.32.0
echo "[INIT]"; inits/get-kind-bash-auto-completion.sh
echo "[INIT]"; inits/get-ctop.sh --version 0.7.7
echo "[INIT]"; inits/get-dive.sh --version 0.13.1
echo "[INIT]"; inits/get-lazydocker.sh --version 0.24.4
echo "[INIT]"; inits/get-kubectl.sh --version 1.37.2
echo "[INIT]"; inits/get-kubectl-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubectl-bash-alias.sh
echo "[INIT]"; inits/get-kubectx.sh --version 0.9.5
echo "[INIT]"; inits/get-kubens.sh --version 0.9.5
echo "[INIT]"; inits/get-kubent.sh --version 0.7.3
echo "[INIT]"; inits/get-kubescape.sh --version 4.0.0
echo "[INIT]"; inits/get-ktop.sh --version 0.5.3
echo "[INIT]"; inits/get-tmux.sh
echo "[INIT]"; inits/get-jq.sh --version 1.7.1
echo "[INIT]"; inits/get-yq.sh --version 4.54.1
echo "[INIT]"; inits/get-kubeconform.sh --version 0.6.4
echo "[INIT]"; inits/get-kustomize.sh --version 5.4.1
echo "[INIT]"; inits/get-kubetail.sh --version 1.6.22
echo "[INIT]"; inits/get-helm.sh --version 3.22.1
echo "[INIT]"; inits/get-helm-bash-auto-completion.sh
echo "[INIT]"; inits/get-fluxcd.sh --version 2.10.0
echo "[INIT]"; inits/get-fluxcd-bash-auto-completion.sh
echo "[INIT]"; inits/get-cilium.sh --version 0.19.0
echo "[INIT]"; inits/get-cilium-bash-auto-completion.sh
echo "[INIT]"; inits/get-k9s.sh --version 0.51.0

echo "[INIT]"; kind/create-cluster.sh k8s

echo "[INIT]"; inits/get-fluxcd-in-kubernetes.sh
echo "[INIT]"; inits/get-testkube.sh --version 1.16.26
echo "[INIT]"; inits/get-testkube-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubernetes-metrics-server.sh
echo "[INIT]"; inits/get-kube-state-metrics.sh
echo "[INIT]"; inits/get-kubernetes-node-exporter.sh
echo "[INIT]"; inits/get-kubernetes-dashboard.sh

