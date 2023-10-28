# Traefik

Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy.

Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically.

## Traefik 2

> This assumes you have installed [helm](../linux/shared/scripts/helm-install.sh).

1. Add `traefik` helm repo and update.

```sh
helm repo add traefik https://helm.traefik.io/traefik

helm repo update
```

2. Setup Traefik CRDs.

```sh
TRAEFIK_VERSION="v2.10.5"

# Install Traefik Resource Definitions
kubectl apply -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml"

# Install RBAC for Traefik:
kubectl apply -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml"
```

3. Setup Traefik pre-requisites.

```sh
mkdir -p "${HOME}/.kube/manifests/kube-system/traefik2"

# Set customizations for the local copy
export WILDCARD_CERTIFICATE_NAME="wildcard-example-com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/kube-system/traefik/traefik2.yml" > "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"

cat "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"

# Check status
kubectl get --namespace kube-system TLSStore default

kubectl get --namespace kube-system Middleware headers-default
```

4. Setup Traefik helm chart.

```sh
# Set customizations for the local copy
export METALLB_TRAEFIK_IP_ADDR="192.168.3.1" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/kube-system/traefik/traefik2-chart-values.yml" > "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

cat "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

# Apply the helm chart values using the local copy
helm install --namespace kube-system traefik traefik/traefik -f "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

# Update the helm chart
# helm uninstall --namespace kube-system traefik
#
# helm install --namespace kube-system traefik traefik/traefik -f "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

# Check status
watch kubectl --namespace kube-system get pods --selector "app.kubernetes.io/name=traefik"

TRAEFIK_POD_NAME=$(kubectl --namespace kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name)

kubectl logs --namespace kube-system $TRAEFIK_POD_NAME
```

* Clean up everything.

```sh
TRAEFIK_VERSION="v2.10.5"

kubectl delete --ignore-not-found=true -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml"

kubectl delete --ignore-not-found=true -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml"

kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"
```

## [Optional] Traefik Dashboard

1. Install `apache2-utils` package.

```sh
sudo apt update

sudo apt install -y apache2-utils
```

2. Setup Traefik dashboard

```sh
mkdir -p "${HOME}/.kube/manifests/kube-system/traefik-dashboard"

# Set customizations for the local copy
TRAEFIK_DASHBOARD_USER="admin" # Modify

TRAEFIK_DASHBOARD_PASS="password" # Modify

export TRAEFIK_DASHBOARD_SECRET=$(htpasswd -nb $TRAEFIK_DASHBOARD_USER $TRAEFIK_DASHBOARD_PASS | openssl base64)

export TRAEFIK_DASHBOARD_DOMAIN="traefik.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/kube-system/traefik/traefik-dashboard.yml" > "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

cat "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"
```
