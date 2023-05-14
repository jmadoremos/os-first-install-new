# DNS-over-HTTPS (DoH) service

Creates a DNS service with DoH enabled using [DNSCrypt](https://dnscrypt.info) and [Pi-hole](https://pi-hole.net).

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Create local copy of the manifest
cat "kubernetes/namespaces/default/dns-over-https/manifest.yml" | tee "${HOME}/.kube/manifests/default/dns-over-https.yaml"

# Apply customizations to the local copy

PIHOLE_GATEWAY="192.168.1.1" # Modify

PIHOLE_TIMEZONE="Asia/Manila" # Modify

PIHOLE_PASSWORD="SUPER_SECURE_PASSWORD_FOR_WEB_UI" # Modify

sed -i "s|\[PIHOLE_CIDR\]|${PIHOLE_CIDR}|g" "${HOME}/.kube/manifests/default/dns-over-https.yaml"

sed -i "s|\[PIHOLE_GATEWAY\]|${PIHOLE_GATEWAY}|g" "${HOME}/.kube/manifests/default/dns-over-https.yaml"

sed -i "s|\[PIHOLE_TIMEZONE\]|${PIHOLE_TIMEZONE}|g" "${HOME}/.kube/manifests/default/dns-over-https.yaml"

sed -i "s|\[PIHOLE_PASSWORD\]|${PIHOLE_PASSWORD}|g" "${HOME}/.kube/manifests/default/dns-over-https.yaml"

cat "${HOME}/.kube/manifests/default/dns-over-https.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/default/dns-over-https.yaml"

# Check status
kubectl get all
```

Remove the deployment.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/default/dns-over-https.yaml"
```
