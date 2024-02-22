#!/bin/bash

kubernetes_dashboard_version=2.7.0

is_already_installed=$( kubectl get all -n kubernetes-dashboard )
if [ ${is_already_installed:0:2} == "No" ]; then
	echo "Installing Kubernetes Dashboard..."
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v$kubernetes_dashboard_version/aio/deploy/recommended.yaml
	kubectl get all -n kubernetest-dashboard
	echo "getting things ready..."
	sleep 10

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
	kubectl -n kubernetes-dashboard create token admin-user
else
	echo "Kubernetes Dashboard already installed"
fi

kubectl -n kubernetes-dashboard create token admin-user --duration 12h

echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
kubectl proxy

