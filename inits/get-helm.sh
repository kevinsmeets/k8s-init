#!/bin/bash

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/tool-installer.sh"

tool_name=helm
releases_url="https://github.com/helm/helm/releases"
version_args=(version)

function download_tool {
    download_archive "https://get.helm.sh/helm-v$tool_version-linux-amd64.tar.gz" linux-amd64/helm
}

install_tool "$@"
