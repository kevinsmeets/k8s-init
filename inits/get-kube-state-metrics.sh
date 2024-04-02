#!/bin/bash

is_already_installed="$(kubectl get deployment kube-state-metrics -n kube-system 2>&1)"

# echo "$is_already_installed"

if [ "${is_already_installed:0:4}" == "NAME" ]; then
	echo "kube-state-metrics is already installed!"
	exit 1
fi

wget https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service-account.yaml
wget https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role.yaml
wget https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/cluster-role-binding.yaml
wget https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/deployment.yaml
wget https://raw.githubusercontent.com/kubernetes/kube-state-metrics/main/examples/standard/service.yaml

kubectl -n kube-system apply -f service-account.yaml
kubectl -n kube-system apply -f cluster-role.yaml
kubectl -n kube-system apply -f cluster-role-binding.yaml
kubectl -n kube-system apply -f deployment.yaml
kubectl -n kube-system apply -f service.yaml

kubectl -n kube-system rollout status deployment kube-state-metrics --timeout=3m

rm service-account.yaml
rm cluster-role.yaml
rm cluster-role-binding.yaml
rm deployment.yaml
rm service.yaml
