#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=dive
releases_url="https://github.com/wagoodman/dive/releases"
version_args=(version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/dive_${tool_version}_linux_amd64.tar.gz" dive
}

install_tool "$@"

