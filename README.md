# k8s-init

[![GitHub Actions](https://github.com/kevinsmeets/k8s-init/actions/workflows/ci.yml/badge.svg)](https://github.com/kevinsmeets/k8s-init/actions)

A bundle of kubernetes tools.

## Install or Update a CLI Tool

The release-download installers uses these flags:

```bash
./inits/get-helm.sh --help
./inits/get-helm.sh --version 3.22.1
./inits/get-helm.sh --version 3.22.1 --uninstall-current
```

- `--version` (`-v`) is required; consult the release link in `--help`.
- `--uninstall-current` (`-u`) permits replacement of an existing installation.
- `--help` (`-h`) prints usage without downloading or installing anything.

The migrated installers are ctop, dive, Flux (`get-fluxcd.sh`), Helm, jq,
kubeconform, kubectl, kubectx, kubens, kubent, kubescape, kubetail, kustomize,
lazydocker, ktop, Testkube, and yq. They accept versions with or without a leading
`v` and share argument validation, temporary-directory cleanup, and installation
handling in `inits/lib/tool-installer.sh`. Keep that helper alongside the scripts.
The existing kind, Cilium, and k9s installers retain their original implementation.

Downloads and extraction must succeed before an existing binary is replaced.
HTTP, extraction, and installation failures stop the script. Testkube installs
`kubectl-testkube` and maintains the `testkube` symlink. kubectx and kubens print
help after installation; other migrated tools print their version.

Run these scripts as your normal user; they invoke `sudo` when installing. You
need Bash, curl, standard Linux utilities, and tar for archive-based installers.
Binary downloads target Linux amd64, as before. The default install directory is
`/usr/local/bin`; `INSTALL_DIR` can select another existing directory for migrated
installers, but installation still invokes `sudo`.

`get-k8s.sh` now passes explicit versions to these installers. Previously pinned
versions are preserved; formerly floating downloads are pinned too, with Helm
remaining on version 3. Edit the version arguments there to select releases for
the full setup. Running an individual installer without a version no longer
selects a hard-coded or latest release.

Docker bootstrap, apt-based tmux installation, shell completion/alias scripts,
and Kubernetes resource deployments are unchanged. They do not use the same
standalone release-binary installation workflow.

## Checks

```bash
bash tests/tool-installers.sh
```

The offline regression suite exercises all 17 migrated installers with mocked
downloads and sudo, real archive extraction, and temporary install directories.
It checks arguments, release URLs, replacement guards, failure cleanup, and the
Testkube symlink without network access or changes to system binaries. CI runs
this suite alongside ShellCheck; the full setup job still performs real installs.

