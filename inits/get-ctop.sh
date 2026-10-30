#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=ctop
releases_url="https://github.com/bcicen/ctop/releases"
version_args=(-v)

function download_tool {
    curl -fL "$releases_url/download/v$tool_version/ctop-$tool_version-linux-amd64" -o "$work_dir/ctop"
}

install_tool "$@"

