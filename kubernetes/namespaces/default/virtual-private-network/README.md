# Virtual Private Network (VPN)

Creates a VPN service using [Wireguard](https://www.wireguard.com/).

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export METALLB_WIREGUARD_IP_ADDR="192.168.3.3" # Modify

export WIREGUARD_CLIENT_NAMES="Client0,Client1,Client2" # Modify

export TIMEZONE="Asia/Manila" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/default/virtual-private-network/manifest.yml" > "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

cat "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

# Check status
kubectl get all
```

Remove the deployment.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/default/virtual-private-network.yaml"
```
