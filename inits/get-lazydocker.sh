#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=lazydocker
releases_url="https://github.com/jesseduffield/lazydocker/releases"
version_args=(--version)

function download_tool {
    download_archive "$releases_url/download/v$tool_version/lazydocker_${tool_version}_Linux_x86_64.tar.gz" lazydocker
}

install_tool "$@"

