#!/bin/bash

# Load version configuration
source "$(dirname "$0")/versions.env"

echo "Checking if docker is installed.."
if ! docker_loc="$(type -p "docker")" || [[ -z $docker_loc ]]; then
  echo "No docker on this system!"
  exit 1
fi

echo "This system has docker!"
docker --version

echo
echo "Create k8s environment..."

echo "[INIT]"; inits/get-kind.sh --version "$KIND_VERSION"
echo "[INIT]"; inits/get-kind-bash-auto-completion.sh
echo "[INIT]"; inits/get-ctop.sh --version "$CTOP_VERSION"
echo "[INIT]"; inits/get-dive.sh --version "$DIVE_VERSION"
echo "[INIT]"; inits/get-lazydocker.sh --version "$LAZYDOCKER_VERSION"
echo "[INIT]"; inits/get-kubectl.sh --version "$KUBECTL_VERSION"
echo "[INIT]"; inits/get-kubectl-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubectl-bash-alias.sh
echo "[INIT]"; inits/get-kubectx.sh --version "$KUBECTX_VERSION"
echo "[INIT]"; inits/get-kubens.sh --version "$KUBENS_VERSION"
echo "[INIT]"; inits/get-kubent.sh --version "$KUBENT_VERSION"
echo "[INIT]"; inits/get-kubescape.sh --version "$KUBESCAPE_VERSION"
echo "[INIT]"; inits/get-ktop.sh --version "$KTOP_VERSION"
echo "[INIT]"; inits/get-tmux.sh
echo "[INIT]"; inits/get-jq.sh --version "$JQ_VERSION"
echo "[INIT]"; inits/get-yq.sh --version "$YQ_VERSION"
echo "[INIT]"; inits/get-kubeconform.sh --version "$KUBECONFORM_VERSION"
echo "[INIT]"; inits/get-kustomize.sh --version "$KUSTOMIZE_VERSION"
echo "[INIT]"; inits/get-kubetail.sh --version "$KUBETAIL_VERSION"
echo "[INIT]"; inits/get-helm.sh --version "$HELM_VERSION"
echo "[INIT]"; inits/get-helm-bash-auto-completion.sh
echo "[INIT]"; inits/get-fluxcd.sh --version "$FLUXCD_VERSION"
echo "[INIT]"; inits/get-fluxcd-bash-auto-completion.sh
echo "[INIT]"; inits/get-cilium.sh --version "$CILIUM_VERSION"
echo "[INIT]"; inits/get-cilium-bash-auto-completion.sh
echo "[INIT]"; inits/get-k9s.sh --version "$K9S_VERSION"

echo "[INIT]"; kind/create-cluster.sh k8s

echo "[INIT]"; inits/get-fluxcd-in-kubernetes.sh
echo "[INIT]"; inits/get-testkube.sh --version "$TESTKUBE_VERSION"
echo "[INIT]"; inits/get-testkube-bash-auto-completion.sh
echo "[INIT]"; inits/get-kubernetes-metrics-server.sh
echo "[INIT]"; inits/get-kube-state-metrics.sh
echo "[INIT]"; inits/get-kubernetes-node-exporter.sh
echo "[INIT]"; inits/get-kubernetes-dashboard.sh

