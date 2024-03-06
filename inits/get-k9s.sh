#!/bin/bash

uninstall_current=false
k9s_version=""

function usage {
	echo "$0 --version <k9s version number>"
}

while [ $# -gt 0 ]; do
	if [[ $1 == "-h" || $1 == "--help" ]]; then
		usage
	elif [[ $1 == "-u" || $1 == "--uninstall-current" ]]; then
		uninstall_current=true
	elif [[ $1 == "-v" || $1 == "--version" ]]; then
		k9s_version="$2"
		shift
	else
		echo "$0: unknown option: $1"
		exit 1
	fi
	shift
done

if [[ -f /usr/local/bin/k9s && $uninstall_current == false ]]; then
	echo "k9s already installed!"
	exit 1
fi

function die {
    printf "ERROR: %s\n\n" "$1"
    exit 1
}

if [[ -z $k9s_version ]]; then
    usage
    die "Missing parameter --version"
fi

echo "uninstall_current: "$uninstall_current
echo "k9s_version: $k9s_version"

if [[ -f /usr/local/bin/k9s && $uninstall_current == true ]]; then
        sudo rm /usr/local/bin/k9s
        echo "Current version uninstalled!"
fi

echo "Installing k9s..."

curl -LO "https://github.com/derailed/k9s/releases/download/v$k9s_version/k9s_Linux_amd64.tar.gz"

tar xzf k9s_Linux_amd64.tar.gz k9s

sudo mv k9s /usr/local/bin/
sudo chmod +x /usr/local/bin/k9s

rm k9s_Linux_amd64.tar.gz

k9s version
