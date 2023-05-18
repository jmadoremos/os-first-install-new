# Kubernetes | Pods Deployment for Network Services

This container bundle contains core services to serve a Domain Name System (DNS) woth support for DNS over HTTPS (DoH).

## Installation

```sh
POD_NAMESPACE="network-services"

# Create namespace
kubectl create namespace $POD_NAMESPACE

# Create pods
kubectl apply -n $POD_NAMESPACE -f "kubernetes/namespaces/network-services/manifests/wireguard.yaml"
```

## Cleanup

```sh
POD_NAMESPACE="network-services"

# Remove pods
kubectl delete --ignore-not-found=true -n $POD_NAMESPACE -f "kubernetes/namespaces/network-services/manifests/wireguard.yaml"

# Remove namespace
kubectl delete namespaces $POD_NAMESPACE
```
