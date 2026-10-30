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
- **Tool Installer Tests** — Exercises all 20 installers with mocked downloads and real extraction
- **Integration Tests** — Validates full setup workflow (when CI runs on main branch)

The test suite runs offline with mocked downloads, ensuring reliability without external dependencies. All CI results are visible in [GitHub Actions](https://github.com/kevinsmeets/k8s-init/actions).

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
4. Add tests to `tests/tool-installers.sh`
5. Run `bash tests/tool-installers.sh` locally
6. Submit a pull request

Renovate will automatically handle version updates; focus on functionality and compatibility.

## License

See [LICENSE](./LICENSE) file for details.

