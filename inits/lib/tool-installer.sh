#!/bin/bash

set -euo pipefail

tool_name=""
releases_url=""
version_args=()

function usage {
    echo "Install and update $tool_name."
    echo
    echo "$releases_url"
    echo
    echo "This script uses 'sudo' and will prompt for sudo password when needed;"
    echo "do not run this script using sudo or root user."
    echo
    echo "usage: $0 --version <version number> [--uninstall-current]"
    echo "  -v, --version            Release version (with or without a leading v)"
    echo "  -u, --uninstall-current  Replace the existing installation"
    echo "  -h, --help               Show this help"
}

function die {
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

function download_archive {
    curl -fL "$1" -o "$work_dir/archive.tar.gz"
    tar -xzf "$work_dir/archive.tar.gz" -C "$work_dir" "$2"
    if [[ "$2" != "$tool_name" ]]; then
        mv "$work_dir/$2" "$work_dir/$tool_name"
    fi
}

function install_tool {
    local uninstall_current=false
    local tool_version=""
    local work_dir
    local install_dir="${INSTALL_DIR:-/usr/local/bin}"
    local destination="$install_dir/${binary_name:-$tool_name}"
    local command_path="$install_dir/$tool_name"

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) usage; exit 0 ;;
            -u|--uninstall-current) uninstall_current=true ;;
            -v|--version)
                [[ $# -ge 2 && -n "$2" && "$2" != -* ]] || die "Missing parameter --version"
                tool_version="${2#v}"
                shift
                ;;
            *) die "Unknown option: $1" ;;
        esac
        shift
    done

    if [[ -z "$tool_version" ]]; then
        usage
        die "Missing parameter --version"
    fi
    [[ "$tool_version" =~ ^[0-9][0-9A-Za-z.+_-]*$ ]] || die "Invalid version: $tool_version"
    if [[ -e "$destination" || -L "$destination" || -e "$command_path" || -L "$command_path" ]]; then
        [[ "$uninstall_current" == true ]] || die "$tool_name already installed! Use --uninstall-current to replace it."
    fi

    echo "uninstall_current: $uninstall_current"
    echo "${tool_name}_version: $tool_version"
    echo "Installing $tool_name..."

    work_dir="$(mktemp -d)"
    # shellcheck disable=SC2064
    trap "$(printf 'rm -rf -- %q' "$work_dir")" EXIT
    download_tool
    [[ -s "$work_dir/$tool_name" ]] || die "Download did not produce $tool_name"
    sudo install -o root -g root -m 0755 "$work_dir/$tool_name" "$destination"
    if [[ "$command_path" != "$destination" ]]; then
        sudo ln -sfn "$destination" "$command_path"
    fi
    "$destination" "${version_args[@]}"
    rm -rf -- "$work_dir"
    trap - EXIT
}