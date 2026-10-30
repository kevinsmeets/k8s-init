#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=kubetail
releases_url="https://github.com/johanhaleby/kubetail/releases"
version_args=(--version)

function download_tool {
    curl -fL "https://raw.githubusercontent.com/johanhaleby/kubetail/$tool_version/kubetail" -o "$work_dir/kubetail"
}

install_tool "$@"

