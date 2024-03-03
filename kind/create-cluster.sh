#!/bin/bash
if ! [ -f /usr/local/bin/kind ]; then
	echo kind is not installed!
	exit 1
fi

echo "Create k8s cluster using kind..."
echo

echo "Is KUBECONFIG environment variable set:"
echo "$KUBECONFIG"

echo "Is a kubectl configuation file present:"
ls -hal "$HOME/.kube"

if [ -f "$HOME/.kube/config" ]; then
	number_of_lines=$( wc -l < "$HOME/.kube/config" )
	if [ "$number_of_lines" -gt 3 ]; then
		echo "A ~/.kube/config file is present, exiting in order to prevent overwriting or modification of your kubectl configuration!"
		exit 1
	fi
fi

cluster_name=$1

if [ -z "$cluster_name" ]; then
	echo
	echo "Please enter a name for your kubernetes cluster:"
	read -r cluster_name
fi

echo "Creating kubernetes cluster named $cluster_name ..."
kind create cluster \
	--name "$cluster_name" \
	--config kind/two-node-cluster.yaml \
	--wait 180s

rc=$?
if [ $rc -ne 0 ]; then
	echo "Something is wrong, return code $rc for 'kind create cluster'"
	exit 1
fi

echo "Cluster has been created:"
kubectl cluster-info
