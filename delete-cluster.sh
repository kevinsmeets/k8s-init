#!/bin/bash
if ! [ -f /usr/local/bin/kind ]; then
	echo kind is not installed!
	exit 1
fi

echo
echo Please enter the name for the kubernetes cluster to delete:
read cluster_name

echo Deleting kubernetes cluster named $cluster_name ...
kind delete cluster --name $cluster_name

rc=$?
if [ $rc -ne 0 ]; then
	echo Something is wrong, return code $rc for 'kind delete cluster'
	exit 1
fi

