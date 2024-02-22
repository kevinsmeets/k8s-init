#!/bin/bash
if ! [ -f /usr/local/bin/kind ]; then
	echo kind is not installed!
	exit 1
fi

echo Is KUBECONFIG environment variable set:
echo $KUBECONFIG

echo Is a kubectl configuation file present:
ls -hal $HOME/.kube

if [ -f $HOME/.kube/config ]; then
	number_of_lines=$( cat $HOME/.kube/config | wc -l )
	if [ $number_of_lines -gt 3 ]; then
		echo A ~/.kube/config file is present, exiting in order to prevent overwriting or modification of your kubectl configuration!
		exit 1
	fi
fi

docker version
kind version
kubectl version

echo
echo Please enter a name for your kubernetes cluster:
read cluster_name

echo Creating kubernetes cluster named $cluster_name ...
kind create cluster --name $cluster_name

rc=$?
if [ $rc -ne 0 ]; then
	echo Something is wrong, return code $rc for 'kind create cluster'
	exit 1
fi

echo Cluster has been created:
kubectl cluster-info
