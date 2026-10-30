#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubeconform
releases_url="https://github.com/yannh/kubeconform/releases"
version_args=(-v)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/kubeconform-linux-amd64.tar.gz" kubeconform
}

install_tool "$@"
