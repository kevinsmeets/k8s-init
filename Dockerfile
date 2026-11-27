FROM debian:trixie-slim@sha256:8aa5a7bf5a1955bddbe7d74fcdd0b91ab30e74362a8b73af672b0481b35b44a0 AS base

FROM base AS builder
ARG TARGETARCH
RUN test "$TARGETARCH" = amd64 || { echo "Only linux/amd64 release binaries are supported" >&2; exit 1; }
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl sudo \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY versions.env image/install-tools.sh ./
COPY inits/lib/tool-installer.sh inits/lib/
COPY inits/get-*.sh inits/
RUN --mount=type=secret,id=build-ca-bundle,target=/etc/ssl/certs/ca-certificates.crt \
    bash install-tools.sh

FROM base
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates docker-cli tmux \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --uid 1000 --shell /bin/bash tools
COPY --from=builder /usr/local/bin/ /usr/local/bin/

USER tools
WORKDIR /home/tools
CMD ["bash"]
