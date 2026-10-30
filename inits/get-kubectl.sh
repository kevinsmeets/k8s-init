#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubectl
releases_url="https://github.com/kubernetes/kubernetes/releases"
version_args=(version --client)

function download_tool {
    curl -fL "https://dl.k8s.io/release/v$tool_version/bin/linux/amd64/kubectl" -o "$work_dir/kubectl"
}

install_tool "$@"
