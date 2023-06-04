# Monitoring

1. Add Prometheus chart.

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update
```

2. Setup pre-requisite resources.

```sh
mkdir -p "${HOME}/.kube/manifests/monitoring"

# Set customizations for the local copy
export GRAFANA_ADMIN_USERNAME="admin" # Modify

export GRAFANA_ADMIN_PASSWORD="SUPER#secret_Passw0Rd" # Modify

export GRAFANA_DOMAIN="grafana.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/monitoring/manifest.yml" > "${HOME}/.kube/manifests/monitoring/manifest.yaml"

cat "${HOME}/.kube/manifests/monitoring/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/monitoring/manifest.yaml"

# Check status
kubectl get all
```

3. Install Prometheus stack using helm.

```sh
# Set customizations for the local copy
export K8S_MASTER_NODE_IP_ADDRS="[192.168.1.1, 192.168.1.2]" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/monitoring/prometheus-chart-values.yml" > "${HOME}/.kube/manifests/monitoring/prometheus-chart-values.yaml"

cat "${HOME}/.kube/manifests/monitoring/prometheus-chart-values.yaml"

# Install the helm chart passing the local copy of the values
helm install --namespace monitoring prometheus prometheus-community/kube-prometheus-stack -f "${HOME}/.kube/manifests/monitoring/prometheus-chart-values.yaml"

# Update the helm chart
# helm upgrade -n monitoring prometheus prometheus-community/kube-prometheus-stack -f "${HOME}/.kube/manifests/monitoring/prometheus-chart-values.yaml"
```

* Clean up

```sh
helm uninstall --namespace monitoring prometheus

kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/monitoring/manifest.yaml"
```
