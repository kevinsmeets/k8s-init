#!/bin/bash

uninstall_current=false
cilium_version=""

function usage {
	echo "Install and update cilium."
	echo
	echo "https://github.com/cilium/cilium-cli/releases"
	echo
	echo "This script uses 'sudo' and will prompt for sudo password when needed;"
	echo "do not run this script using sudo or root user."
	echo
	echo "usage: $0 --version <cilium version number> [--uninstall-current]"
}

while [ $# -gt 0 ]; do
	if [[ $1 == "-h" || $1 == "--help" ]]; then
		usage
		exit 0
	elif [[ $1 == "-u" || $1 == "--uninstall-current" ]]; then
		uninstall_current=true
	elif [[ $1 == "-v" || $1 == "--version" ]]; then
		cilium_version="$2"
		shift
	else
		echo "$0: unknown option: $1"
		exit 1
	fi
	shift
done

if [[ -f /usr/local/bin/cilium && $uninstall_current == false ]]; then
	echo "cilium already installed!"
	exit 1
fi

function die {
    printf "ERROR: %s\n\n" "$1"
    exit 1
}

if [[ -z $cilium_version ]]; then
    usage
    die "Missing parameter --version"
fi

echo "uninstall_current: "$uninstall_current
echo "cilium_version: $cilium_version"

if [[ -f /usr/local/bin/cilium && $uninstall_current == true ]]; then
        sudo rm /usr/local/bin/cilium
        echo "Current version uninstalled!"
fi

echo "Installing cilium..."

curl -Lo ./cilium-linux-amd64.tar.gz "https://github.com/cilium/cilium-cli/releases/download/v$cilium_version/cilium-linux-amd64.tar.gz"
tar -xzf ./cilium-linux-amd64.tar.gz
rm cilium-linux-amd64.tar.gz

chmod +x ./cilium
sudo mv ./cilium /usr/local/bin/cilium
cilium version --client
