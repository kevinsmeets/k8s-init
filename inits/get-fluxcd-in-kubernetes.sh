#!/bin/bash
if ! [ -f /usr/local/bin/flux ]; then
  echo "flux is not installed!"
  exit 1
fi

echo Installing FluxCD in kubernetes...
flux install

kubectl -n flux-system rollout status deployment/helm-controller --timeout=3m
kubectl -n flux-system rollout status deployment/kustomize-controller --timeout=3m
kubectl -n flux-system rollout status deployment/notification-controller --timeout=3m
kubectl -n flux-system rollout status deployment/source-controller --timeout=3m

flux --version
