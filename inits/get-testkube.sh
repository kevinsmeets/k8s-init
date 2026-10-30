#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=testkube
binary_name=kubectl-testkube
releases_url="https://github.com/kubeshop/testkube/releases"
version_args=(version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/testkube_${tool_version}_Linux_x86_64.tar.gz" kubectl-testkube
}

install_tool "$@"
