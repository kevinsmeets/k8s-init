# k8s-init

[![GitHub Actions](https://github.com/kevinsmeets/k8s-init/actions/workflows/ci.yml/badge.svg)](https://github.com/kevinsmeets/k8s-init/actions)

A comprehensive bundle of Kubernetes CLI tools and automation scripts for bootstrapping a complete Kubernetes development environment with [KinD (Kubernetes in Docker)](https://kind.sigs.k8s.io/).

## Overview

`k8s-init` simplifies Kubernetes development setup by:

- **Installing 20+ essential tools** — KinD, kubectl, Helm, Flux CD, Cilium, k9s, and more
- **Creating a local Kubernetes cluster** — Using KinD for lightweight, containerized Kubernetes testing
- **Automating dependency updates** — Using [Renovate](https://www.whitesourcesoftware.com/free-developer-tools/renovate/) to keep tool versions current
- **Ensuring code quality** — With continuous integration checks (ShellCheck, tool validation)

## Quick Start

### Prerequisites

- Docker installed and running
- Bash 4+
- `curl`, standard Linux utilities, and `tar`

### Run Full Setup

```bash
./get-k8s.sh
```

This single command:
1. Verifies Docker is installed
2. Installs all 20 tools (see `versions.env` for tool list)
3. Creates a local KinD cluster named `k8s`
4. Installs cluster components (Flux CD, metrics server, Kubernetes Dashboard, etc.)

### Use the toolbox image instead

To work with an existing cluster without installing tools on the host, use
`ghcr.io/kevinsmeets/k8s-tools`. The image contains all 20 CLIs pinned in
[`versions.env`](./versions.env), plus Bash, tmux and the Docker client. It runs
as a non-root user (UID 1000) and does not create a cluster. Only `linux/amd64`
is supported because the installers currently download AMD64 binaries.

```bash
image=ghcr.io/kevinsmeets/k8s-tools:latest
docker pull "$image"
docker run --rm "$image" kubectl version --client
docker run --rm -it "$image"    # interactive Bash

# Use your existing kubeconfig without copying it into the image
docker run --rm -it -e KUBECONFIG=/tmp/kubeconfig \
  --mount "type=bind,src=$HOME/.kube/config,dst=/tmp/kubeconfig,readonly" \
  "$image" k9s
```

The kubeconfig must be readable by the container user. If it references external
certificate files or an authentication plugin, those must also be available in
the container. The API server must be reachable from inside the container:
`127.0.0.1` normally refers to the container, not the host. Docker-backed tools
such as KinD need access to a separately supplied Docker daemon; the image does
not start one or mount the host socket.

The [image workflow](./.github/workflows/tools-image.yml) builds and tests the
image on pull requests to `main` without publishing. On a push to `main`
(including a merged Renovate update), it publishes the tested image to GHCR as
`latest` and `sha-<full-commit>`. Use the SHA tag or image digest when you need a
specific build. For anonymous pulls, the package owner must make the GHCR
package public after the first publish.

To reproduce the image check locally from the repository root:

```bash
docker buildx build --platform linux/amd64 --load -t k8s-tools:local .
docker run --rm -i --network none \
  --mount "type=bind,src=$PWD/versions.env,dst=/tmp/versions.env,readonly" \
  k8s-tools:local bash -s < tests/tools-image.sh
```

If your network uses a private HTTPS proxy CA, add
`--secret id=build-ca-bundle,src=/etc/ssl/certs/ca-certificates.crt` to the build
command, using the path to your trusted PEM bundle. It is mounted only while
downloading the tools and is not included in the image.

## Tool Installation

### Individual Tool Installation

Each tool has its own installer script in the `inits/` directory:

```bash
# View help for a tool
./inits/get-helm.sh --help

# Install or update a tool to a specific version
./inits/get-helm.sh --version 3.22.1

# Replace an existing installation
./inits/get-helm.sh --version 3.22.1 --uninstall-current
```

### Available Tools

All tool versions are centralized in [`versions.env`](./versions.env):

| Tool | Purpose |
|------|---------|
| **kind** | Kubernetes in Docker cluster creation |
| **kubectl** | Kubernetes command-line tool |
| **helm** | Kubernetes package manager |
| **flux** | GitOps for Kubernetes |
| **cilium** | Kubernetes networking and security |
| **k9s** | Terminal UI for Kubernetes |
| **kustomize** | Kubernetes configuration management |
| **kubectx/kubens** | Switch contexts and namespaces |
| **kube-no-trouble** | Deprecation checker |
| **kubescape** | Kubernetes security scanner |
| **kubetail** | Tail logs from multiple pods |
| **dive** | Docker image explorer |
| **lazydocker** | Docker terminal UI |
| **ctop** | Container metrics |
| **ktop** | Kubernetes top (node metrics) |
| **kubeconform** | Kubernetes manifest validator |
| **helm, kubectl, flux** | Shell completion and aliases |
| **jq, yq** | JSON/YAML processors |
| **testkube** | Kubernetes testing framework |

### Installation Options

- `--version` (`-v`) — Specify the release version (required)
- `--uninstall-current` (`-u`) — Replace an existing installation
- `--help` (`-h`) — Display usage without downloading

All scripts run as your normal user and invoke `sudo` only when necessary. The default install directory is `/usr/local/bin`; use `INSTALL_DIR` environment variable to install elsewhere.

## Dependency Management with Renovate

This repository uses [Renovate](https://docs.renovatebot.com/) to automatically manage tool versions and create pull requests when updates are available.

### How It Works

1. **Version Centralization** — All tool versions are defined in [`versions.env`](./versions.env)
2. **Automated Detection** — Renovate scans for new releases from GitHub every Monday
3. **Pull Requests** — Updates are grouped by tool category (Kubernetes, Infrastructure)
4. **CI Validation** — All PRs run through automated tests before merging
5. **Easy Updates** — Simply merge Renovate PRs to keep tools current

### Configuration

- **[renovate.json](./renovate.json)** — Renovate configuration file
- **[versions.env](./versions.env)** — Centralized version management

See [Renovate documentation](https://docs.renovatebot.com/) for advanced configuration options.

## Continuous Integration

This repository runs automated tests on every commit:

```bash
bash tests/tool-installers.sh
```

### CI Checks

- **ShellCheck** — Validates shell script syntax and best practices
- **Tool Installer Tests** — Exercise the shared-library installers with mocked downloads and real extraction
- **Integration Tests** — Validate the host setup against a live KinD cluster
- **Toolbox Image Test** — Builds with real downloads, then checks the final image offline, including its non-root user, CLI availability, Testkube alias and pinned kubectl, Helm and k9s versions

All CI results are visible in [GitHub Actions](https://github.com/kevinsmeets/k8s-init/actions).

## Architecture

### Key Directories

- `inits/` — Individual tool installer scripts
- `inits/lib/` — Shared installer utilities and helpers
- `kind/` — KinD cluster creation scripts
- `tests/` — Offline test suite for validation
- `.github/workflows/` — CI/CD pipeline configuration

### Shared Installer Library

Most installers use `inits/lib/tool-installer.sh`, which provides:
- Argument validation
- Release URL verification
- Download and extraction
- Safe binary replacement
- Temporary directory cleanup
- Version output validation

## Usage Examples

### Full Environment Setup

```bash
# Install Docker, create cluster, and deploy all tools
./get-k8s.sh

# Access Kubernetes Dashboard
kubectl port-forward -n kubernetes-dashboard svc/kubernetes-dashboard 8443:443
```

### Update a Single Tool

```bash
# Update Helm to a newer version
./inits/get-helm.sh --version 3.23.0 --uninstall-current

# Verify installation
helm version
```

### Use KinD Cluster

```bash
# Interact with the cluster
kubectl get nodes
kubectl get pods --all-namespaces

# Deploy applications using Helm
helm install my-release bitnami/nginx --namespace default
```

## Contributing

To add or update a tool:

1. Create or update the installer script in `inits/get-<tool>.sh`
2. Add/update the version in `versions.env`
3. Update `get-k8s.sh` to include the tool
4. Add installer tests to `tests/tool-installers.sh` and add new CLI names to `tests/tools-image.sh`
5. Run `bash tests/tool-installers.sh` locally
6. Submit a pull request

Renovate will automatically handle version updates; focus on functionality and compatibility.

## License

See [LICENSE](./LICENSE) file for details.

