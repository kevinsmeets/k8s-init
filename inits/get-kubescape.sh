#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubescape
releases_url="https://github.com/kubescape/kubescape/releases"
version_args=(version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/kubescape_${tool_version}_linux_amd64.tar.gz" kubescape
}

install_tool "$@"
