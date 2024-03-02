#!/bin/bash

kubernetes_dashboard_version=2.7.0

is_already_installed="$(kubectl get all -n kubernetes-dashboard 2>&1)"

# echo "$is_already_installed"
#
# No resources found in kubernetes-dashboard namespace.

if [ "${is_already_installed:0:2}" == "No" ]; then
	echo "Installing Kubernetes Dashboard..."
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v$kubernetes_dashboard_version/aio/deploy/recommended.yaml
	kubectl get all -n kubernetest-dashboard
	echo "Getting things ready..."
	kubectl -n kubernetes-dashboard rollout status deployment kubernetes-dashboard --timeout=3m

# Create a new ServiceAccount
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Create a ClusterRoleBinding for the ServiceAccount
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

else
	echo "Kubernetes Dashboard already installed"
fi

echo
echo "Use this token to login to Kubernetes Dashboard:"
kubectl -n kubernetes-dashboard create token admin-user --duration 12h

echo
echo "This is the Kubernetes Dashboard URL:"
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
echo

start_kubectl_proxy=$1

if [ -n "$start_kubectl_proxy" ]; then
	echo "Starting kubectl proxy..."
	kubectl proxy --address 0.0.0.0 --accept-hosts '.*'
else
	echo "Run 'kubectl proxy --address 0.0.0.0 --accept-hosts '.*' ' to access Kubernetes Dashboard"
fi
