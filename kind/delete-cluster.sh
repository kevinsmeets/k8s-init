#!/bin/bash
if ! [ -f /usr/local/bin/kind ]; then
	echo "kind is not installed!"
	exit 1
fi

echo "List of current clusters:"
kind get clusters

cluster_name=$1

if [ -z "$cluster_name" ]; then
	echo
	echo "Please enter the name for the kubernetes cluster to delete:"
	read -r cluster_name
fi

echo "Deleting kubernetes cluster named $cluster_name ..."
kind delete cluster --name "$cluster_name"

rc=$?
if [ $rc -ne 0 ]; then
	echo "Something is wrong, return code $rc for 'kind delete cluster'"
	exit 1
fi

