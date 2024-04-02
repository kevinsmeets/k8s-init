#!/bin/bash

kubectl create namespace monitoring

is_already_installed="$(kubectl get daemonset node-exporter -n monitoring 2>&1)"

echo "$is_already_installed"

if [ "${is_already_installed:0:2}" == "No" ]; then
	echo "node-exporter is already installed!"
	exit 1
fi

if [ ! -f daemonset.yaml ]; then
	wget https://raw.githubusercontent.com/bibinwilson/kubernetes-node-exporter/main/daemonset.yaml
	wget https://raw.githubusercontent.com/bibinwilson/kubernetes-node-exporter/main/service.yaml
fi

kubectl -n monitoring apply -f daemonset.yaml
kubectl -n monitoring apply -f service.yaml

kubectl -n monitoring rollout status daemonset node-exporter --timeout=3m

