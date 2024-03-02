#!/bin/bash

docker version

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
inits/get-testkube.sh
inits/get-testkube-bash-auto-completion.sh
inits/get-k9s.sh

kind/create-cluster.sh k8s

inits/get-kubernetes-metrics-server.sh
inits/get-kubernetes-dashboard.sh
inits/get-fluxcd-in-kubernetes.sh
