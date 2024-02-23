#!/bin/bash

kubernetes_metrics_server_version=0.7.0

is_already_installed="$(kubectl -n kube-system get deployment -l 'k8s-app in (metrics-ser
ver)' 2>&1)"

# echo "$is_already_installed"
#
# No resources found

if [ ${is_already_installed:0:2} == "No" ]; then
	echo "Installing Kubernetes Metrics Server..."
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v$kubernetes_metrics_server_version/components.yaml
	kubectl -n kube-system patch deployment metrics-server --type=json -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
else
	echo "Kubernetes Metrics Server already installed"
fi

echo
echo "kubectl top node"
kubectl top node

echo
echo "kubectl top pod --all-namespaces"
kubectl top pod --all-namespaces
