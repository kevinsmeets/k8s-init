#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=ktop
releases_url="https://github.com/vladimirvivien/ktop/releases"
version_args=(version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/ktop_v${tool_version}_linux_amd64.tar.gz" ktop
}

install_tool "$@"
