# Virtual Private Network (VPN)

Creates a VPN service using [Wireguard](https://www.wireguard.com/).

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Create local copy of the manifest
cat "kubernetes/namespaces/default/virtual-private-network/manifest.yml" | tee "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

# Apply customizations to the local copy
METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

METALLB_WIREGUARD_IP_ADDR="192.168.3.3" # Modify

WIREGUARD_CLIENT_NAMES="Client0,Client1,Client2" # Modify

WIREGUARD_TIMEZONE="Asia/Manila" # Modify

sed -i "s|\[METALLB_PIHOLE_IP_ADDR\]|${METALLB_PIHOLE_IP_ADDR}|g" "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

sed -i "s|\[METALLB_WIREGUARD_IP_ADDR\]|${METALLB_WIREGUARD_IP_ADDR}|g" "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

sed -i "s|\[WIREGUARD_CLIENT_NAMES\]|${WIREGUARD_CLIENT_NAMES}|g" "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

sed -i "s|\[WIREGUARD_TIMEZONE\]|${WIREGUARD_TIMEZONE}|g" "${HOME}/.kube/manifests/default/virtual-private-network.yaml"

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
