#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=flux
releases_url="https://github.com/fluxcd/flux2/releases"
version_args=(--version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/flux_${tool_version}_linux_amd64.tar.gz" flux
}

install_tool "$@"
