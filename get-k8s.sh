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
intis/get-kubeconform.sh
inits/get-helm.sh
inits/get-fluxcd.sh
inits/get-k9s.sh

kind/create-cluster.sh
sleep 10

inits/get-kubernetes-metrics-server.sh
inits/get-kubernetes-dashboard.sh
