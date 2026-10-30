#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubectx
releases_url="https://github.com/ahmetb/kubectx/releases"
version_args=(--help)

function download_tool {
    curl -fL "$releases_url/download/v$tool_version/kubectx" -o "$work_dir/kubectx"
}

install_tool "$@"
