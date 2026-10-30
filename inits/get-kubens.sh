#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubens
releases_url="https://github.com/ahmetb/kubectx/releases"
version_args=(--help)

function download_tool {
    curl -fL "$releases_url/download/v$tool_version/kubens" -o "$work_dir/kubens"
}

install_tool "$@"
