# Kubernetes | Pods Deployment for Portainer

Portainer is a self-service container service delivery platform. It is the definitive container management GUI for Kubernetes, Docker and Swarm.

## Update Manifests

```sh
wget "https://raw.githubusercontent.com/portainer/k8s/master/deploy/manifests/portainer/portainer-lb.yaml" -O "kubernetes/namespaces/portainer/manifests/portainer-lb.yaml"
```

## Installation

```sh
kubectl apply -f "kubernetes/namespaces/portainer/manifests/portainer-lb.yaml"
```

## Cleanup

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/portainer/manifests/portainer-lb.yaml"
```
