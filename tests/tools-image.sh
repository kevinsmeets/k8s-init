#!/bin/bash
set -euo pipefail

# Run inside the final image with the checkout's version pins mounted read-only.
# shellcheck source=../versions.env
source /tmp/versions.env

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
[[ "$(id -u)" != 0 && -w "$HOME" ]] || fail "expected a non-root user with a writable home"

for tool in kind ctop dive lazydocker kubectl kubectx kubens kubent kubescape ktop jq \
    yq kubeconform kustomize kubetail helm flux cilium k9s testkube kubectl-testkube docker tmux; do
    command -v "$tool" >/dev/null || fail "missing executable: $tool"
done
[[ /usr/local/bin/testkube -ef /usr/local/bin/kubectl-testkube ]] || fail "broken Testkube alias"
kubectl testkube --help >/dev/null

check_version() {
    [[ "${3#v}" == "$2" ]] || fail "$1: expected $2, got '$3'"
}
kubectl_version=$(kubectl version --client -o json | jq -er '.clientVersion.gitVersion')
helm_version=$(helm version --template '{{.Version}}')
k9s_version=$(k9s version --short | awk '$1 == "Version" || $1 == "Version:" {print $2}')
check_version kubectl "$KUBECTL_VERSION" "$kubectl_version"
check_version helm "$HELM_VERSION" "$helm_version"
check_version k9s "$K9S_VERSION" "$k9s_version"
echo "Toolbox smoke test passed."
