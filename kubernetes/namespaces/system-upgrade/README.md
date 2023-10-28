# Automated System Upgrade

This service will automatically upgrade the k3s cluster using `stable` channel. This channel is the default. Stable is recommended for production environments. These releases have been through a period of community hardening.

1. Apply the System Upgrade Controller manifest.

```sh
# Create local directory
mkdir -p "${HOME}/.kube/manifests/system-upgrade"

# Download manifest to local directory
curl "https://raw.githubusercontent.com/rancher/system-upgrade-controller/master/manifests/system-upgrade-controller.yaml" -o "${HOME}/.kube/manifests/system-upgrade/system-upgrade-controller.yaml"

# Apply local manifest
kubectl apply -f "${HOME}/.kube/manifests/system-upgrade/system-upgrade-controller.yaml"

# Check status
watch kubectl --namesspace system-upgrade get pods -o yaml
```

2. Apply the Upgrade Plan manifest.

```sh
# Apply upgrade plan
kubectl apply -f "kubernetes/namespaces/system-upgrade/upgrade-plan.yml"

# Check status
watch kubectl --namespace system-upgrade get plans -o yaml
watch kubectl --namespace system-upgrade get jobs -o yaml
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/system-upgrade/upgrade-plan.yml"

kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/system-upgrade/system-upgrade-controller.yaml"
```
