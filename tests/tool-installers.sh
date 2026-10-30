#!/bin/bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
test_dir="$(mktemp -d)"
trap 'rm -rf -- "$test_dir"' EXIT

export INSTALL_DIR="$test_dir/bin"
export TMPDIR="$test_dir/downloads"
export TEST_LOG="$test_dir/commands.log"
export VERSION_LOG="$test_dir/version.log"
export TEST_PAYLOAD="$test_dir/payload"
export TEST_ARCHIVE="$test_dir/release.tar.gz"
export MOCK_FAILURE=""
mkdir -p "$INSTALL_DIR" "$TMPDIR" "$test_dir/archive/linux-amd64"
printf '%s\n' '#!/bin/bash' "printf '%s\\n' \"\$*\" > \"\$VERSION_LOG\"" > "$TEST_PAYLOAD"

function curl {
    [[ $# == 4 && "$1" == -fL && "$3" == -o ]] || return 90
    printf '%s\n' "$2" >> "$TEST_LOG"
    [[ "$MOCK_FAILURE" != download ]] || return 22
    if [[ "$2" == *.tar.gz && "$MOCK_FAILURE" != archive ]]; then
        command cp "$TEST_ARCHIVE" "$4"
    else
        command cp "$TEST_PAYLOAD" "$4"
    fi
}

function sudo {
    printf '%s\n' "$1" >> "$TEST_LOG"
    [[ "$MOCK_FAILURE" != install ]] || return 1
    case "$1" in
        install) command install -m 0755 "${@: -2}" ;;
        ln) command "$@" ;;
        *) return 91 ;;
    esac
}

export -f curl sudo

function fail {
    printf 'FAIL: %s\n' "$*" >&2
    exit 1
}

function run_installer {
    bash "$repo_dir/inits/get-$script_name.sh" "$@" > "$test_dir/output" 2>&1
}

function expect_failure {
    if run_installer "$@"; then
        fail "$script_name unexpectedly accepted: $*"
    fi
}

function assert_clean {
    [[ -z "$(find "$TMPDIR" -mindepth 1 -print -quit)" ]] || fail "$script_name left temporary files"
}

specs=(
    'ctop|ctop||https://github.com/bcicen/ctop/releases/download/v1.2.3/ctop-1.2.3-linux-amd64|-v'
    'dive|dive|dive|https://github.com/wagoodman/dive/releases/download/v1.2.3/dive_1.2.3_linux_amd64.tar.gz|version'
    'fluxcd|flux|flux|https://github.com/fluxcd/flux2/releases/download/v1.2.3/flux_1.2.3_linux_amd64.tar.gz|--version'
    'helm|helm|linux-amd64/helm|https://get.helm.sh/helm-v1.2.3-linux-amd64.tar.gz|version'
    'jq|jq||https://github.com/jqlang/jq/releases/download/jq-1.2.3/jq-linux-amd64|--version'
    'kubeconform|kubeconform|kubeconform|https://github.com/yannh/kubeconform/releases/download/v1.2.3/kubeconform-linux-amd64.tar.gz|-v'
    'kubectl|kubectl||https://dl.k8s.io/release/v1.2.3/bin/linux/amd64/kubectl|version --client'
    'kubectx|kubectx||https://github.com/ahmetb/kubectx/releases/download/v1.2.3/kubectx|--help'
    'kubens|kubens||https://github.com/ahmetb/kubectx/releases/download/v1.2.3/kubens|--help'
    'kubent|kubent|kubent|https://github.com/doitintl/kube-no-trouble/releases/download/1.2.3/kubent-1.2.3-linux-amd64.tar.gz|--version'
    'kubescape|kubescape|kubescape|https://github.com/kubescape/kubescape/releases/download/v1.2.3/kubescape_1.2.3_linux_amd64.tar.gz|version'
    'kubetail|kubetail||https://raw.githubusercontent.com/johanhaleby/kubetail/1.2.3/kubetail|--version'
    'kustomize|kustomize|kustomize|https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v1.2.3/kustomize_v1.2.3_linux_amd64.tar.gz|version'
    'lazydocker|lazydocker|lazydocker|https://github.com/jesseduffield/lazydocker/releases/download/v1.2.3/lazydocker_1.2.3_Linux_x86_64.tar.gz|--version'
    'ktop|ktop|ktop|https://github.com/vladimirvivien/ktop/releases/download/v1.2.3/ktop_v1.2.3_linux_amd64.tar.gz|version'
    'testkube|testkube|kubectl-testkube|https://github.com/kubeshop/testkube/releases/download/v1.2.3/testkube_1.2.3_Linux_x86_64.tar.gz|version'
    'yq|yq||https://github.com/mikefarah/yq/releases/download/v1.2.3/yq_linux_amd64|--version'
)

archive_members=()
for spec in "${specs[@]}"; do
    IFS='|' read -r script_name tool_name member expected_url expected_version_args <<< "$spec"
    if [[ -n "$member" ]]; then
        cp "$TEST_PAYLOAD" "$test_dir/archive/$member"
        archive_members+=("$member")
    fi
done
tar -czf "$TEST_ARCHIVE" -C "$test_dir/archive" "${archive_members[@]}"

for spec in "${specs[@]}"; do
    IFS='|' read -r script_name tool_name member expected_url expected_version_args <<< "$spec"
    : > "$TEST_LOG"
    run_installer --help || fail "$script_name help failed"
    run_installer -h || fail "$script_name short help failed"
    expect_failure
    expect_failure --version
    expect_failure --version ''
    expect_failure --version --uninstall-current
    expect_failure --unknown
    expect_failure --version ../bad
    expect_failure --version v
    [[ ! -s "$TEST_LOG" ]] || fail "$script_name performed work for help or invalid arguments"

    run_installer -v v1.2.3 || fail "$script_name fresh install failed: $(< "$test_dir/output")"
    [[ -x "$INSTALL_DIR/$tool_name" ]] || fail "$script_name missing executable"
    [[ "$(head -n 1 "$TEST_LOG")" == "$expected_url" ]] || fail "$script_name wrong download URL"
    [[ "$(< "$VERSION_LOG")" == "$expected_version_args" ]] || fail "$script_name wrong version command"
    assert_clean

    : > "$TEST_LOG"
    expect_failure --version 1.2.3
    [[ ! -s "$TEST_LOG" ]] || fail "$script_name downloaded despite an existing installation"
    run_installer --version 1.2.3 --uninstall-current || fail "$script_name replacement failed"
    run_installer -u -v 1.2.3 || fail "$script_name short replacement flags failed"
    if [[ "$tool_name" == testkube ]]; then
        [[ -L "$INSTALL_DIR/testkube" && "$(readlink "$INSTALL_DIR/testkube")" == "$INSTALL_DIR/kubectl-testkube" ]] || fail 'Testkube alias missing'
        rm "$INSTALL_DIR/testkube"
        expect_failure --version 1.2.3
        run_installer -u -v 1.2.3 || fail 'Testkube alias was not restored'
    fi

    for MOCK_FAILURE in download install archive; do
        if [[ "$MOCK_FAILURE" == archive && -z "$member" ]]; then
            continue
        fi
        expect_failure --version 1.2.3 --uninstall-current
        cmp -s "$TEST_PAYLOAD" "$INSTALL_DIR/$tool_name" || fail "$script_name damaged the existing installation on $MOCK_FAILURE failure"
        assert_clean
    done
    MOCK_FAILURE=""
    rm "$INSTALL_DIR/$tool_name"
    ln -s "$INSTALL_DIR/missing" "$INSTALL_DIR/$tool_name"
    : > "$TEST_LOG"
    expect_failure --version 1.2.3
    [[ ! -s "$TEST_LOG" ]] || fail "$script_name ignored an existing broken symlink"
    rm "$INSTALL_DIR/$tool_name"
    assert_clean
    printf 'PASS: %s\n' "$script_name"
done

printf 'All %s installer tests passed without network access or root privileges.\n' "${#specs[@]}"