#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubent
releases_url="https://github.com/doitintl/kube-no-trouble/releases"
version_args=(--version)

function download_tool {
    download_archive "$releases_url/download/$tool_version/kubent-$tool_version-linux-amd64.tar.gz" kubent
}

install_tool "$@"

