#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=yq
releases_url="https://github.com/mikefarah/yq/releases"
version_args=(--version)

function download_tool {
    curl -fL "$releases_url/download/v$tool_version/yq_linux_amd64" -o "$work_dir/yq"
}

install_tool "$@"
