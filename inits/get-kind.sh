#!/bin/bash

uninstall_current=false
kind_version=""

function usage {
	echo "Install and update kind."
	echo
	echo "https://github.com/kubernetes-sigs/kind/releases"
	echo
	echo "This script uses 'sudo' and will prompt for sudo password when needed;"
	echo "do not run this script using sudo or root user."
	echo
	echo "usage: $0 --version <kind version number> [--uninstall-current]"
}

while [ $# -gt 0 ]; do
	if [[ $1 == "-h" || $1 == "--help" ]]; then
		usage
		exit 0
	elif [[ $1 == "-u" || $1 == "--uninstall-current" ]]; then
		uninstall_current=true
	elif [[ $1 == "-v" || $1 == "--version" ]]; then
		kind_version="$2"
		shift
	else
		echo "$0: unknown option: $1"
		exit 1
	fi
	shift
done

if [[ -f /usr/local/bin/kind && $uninstall_current == false ]]; then
	echo "kind already installed!"
	exit 1
fi

function die {
    printf "ERROR: %s\n\n" "$1"
    exit 1
}

if [[ -z $kind_version ]]; then
    usage
    die "Missing parameter --version"
fi

echo "uninstall_current: "$uninstall_current
echo "kind_version: $kind_version"

if [[ -f /usr/local/bin/kind && $uninstall_current == true ]]; then
        sudo rm /usr/local/bin/kind
        echo "Current version uninstalled!"
fi

echo "Installing kind..."

curl -Lo ./kind-linux-amd64 "https://github.com/kubernetes-sigs/kind/releases/download/v$kind_version/kind-linux-amd64"

chmod +x ./kind-linux-amd64
sudo mv ./kind-linux-amd64 /usr/local/bin/kind
kind version
