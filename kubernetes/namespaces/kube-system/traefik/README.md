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

2. Setup Traefik pre-requisites.

```sh
mkdir -p "${HOME}/.kube/manifests/kube-system/traefik2"

# Create local copy of the manifest
cat "kubernetes/namespaces/kube-system/traefik/traefik2.yml" | tee "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/kube-system/traefik2/manifest.yaml"

# Check status
kubectl get --namespace kube-system Secret porkbun-apikey

kubectl get --namespace kube-system ConfigMap traefik2

kubectl get --namespace kube-system PersistentVolumeClaim acme-json-certs
```

3. Setup Traefik CRDs.

```sh
TRAEFIK_VERSION="v2.10"

# Install Traefik Resource Definitions
kubectl apply -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml"

# Install RBAC for Traefik:
kubectl apply -f "https://raw.githubusercontent.com/traefik/traefik/${TRAEFIK_VERSION}/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml"
```

4. Setup Traefik helm chart.

```sh
# Create local copy of the manifest
cat "kubernetes/namespaces/kube-system/traefik/traefik2-chart-values.yml" | tee "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

# Apply customizations to the local copy
LOAD_BALANCER_IP="192.168.1.2" # Modify

sed -i "s|\[LOAD_BALANCER_IP\]|${LOAD_BALANCER_IP}|g" "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

cat "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml"

# Apply the helm chart values using the local copy
helm upgrade --namespace=kube-system  -f "${HOME}/.kube/manifests/kube-system/traefik2/chart-values.yaml" traefik traefik/traefik

# Check status
TRAEFIK_POD_NAME=$(kubectl --namespace kube-system get pods --selector "app.kubernetes.io/name=traefik" --output=name)

kubectl logs --namespace kube-system $TRAEFIK_POD_NAME
```

* Clean up everything.

```sh
TRAEFIK_VERSION="v2.10"

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

# Create local copy of the manifest
cat "kubernetes/namespaces/kube-system/traefik/traefik-dashboard.yml" | tee "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

# Apply customizations to the local copy
TRAEFIK_DASHBOARD_USER="admin" # Modify

TRAEFIK_DASHBOARD_PASS="password" # Modify

TRAEFIK_DASHBOARD_SECRET=$(htpasswd -nb $TRAEFIK_DASHBOARD_USER $TRAEFIK_DASHBOARD_PASS | openssl base64)

TRAEFIK_DASHBOARD_DOMAIN="traefik.example.com" # Modify

sed -i "s|\[TRAEFIK_DASHBOARD_SECRET\]|${TRAEFIK_DASHBOARD_SECRET}|g" "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

sed -i "s|\[TRAEFIK_DASHBOARD_DOMAIN\]|${TRAEFIK_DASHBOARD_DOMAIN}|g" "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

cat "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/kube-system/traefik-dashboard/manifest.yaml"
```

* Clean up everything

> There is a need to preserve the `traefik-dashboard` resource with `IngressRoute` kind under `kube-system` namespace. This resource is automatically created when `k3s` is installed.

```sh
kubectl delete --ignore-not-found=true --namespace kube-system Ingress traefik-dashboard

kubectl delete --ignore-not-found=true --namespace kube-system Service traefik-dashboard

kubectl delete --ignore-not-found=true --namespace kube-system Middleware traefik-dashboard-basicauth

kubectl delete --ignore-not-found=true --namespace kube-system Secret traefik-dashboard
```
