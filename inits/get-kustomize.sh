#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kustomize
releases_url="https://github.com/kubernetes-sigs/kustomize/releases"
version_args=(version)

function download_tool {
    download_archive "$releases_url/download/kustomize/v$tool_version/kustomize_v${tool_version}_linux_amd64.tar.gz" kustomize
}

install_tool "$@"
