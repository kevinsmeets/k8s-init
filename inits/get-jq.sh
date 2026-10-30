#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=jq
releases_url="https://github.com/jqlang/jq/releases"
version_args=(--version)

function download_tool {
    curl -fL "$releases_url/download/jq-$tool_version/jq-linux-amd64" -o "$work_dir/jq"
}

install_tool "$@"

