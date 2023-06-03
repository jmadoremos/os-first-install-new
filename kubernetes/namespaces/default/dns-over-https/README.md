# DNS-over-HTTPS (DoH) service

Creates a DNS service with DoH enabled using [DNSCrypt](https://dnscrypt.info) and [Pi-hole](https://pi-hole.net).

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Set customizations for the local copy
export CLOUDFLARE_REGISTERED_DOMAIN="example.com" # Modify

export PIHOLE_CIDR="192.168.1.0/24" # Modify

export PIHOLE_GATEWAY="192.168.1.1" # Modify

export PIHOLE_PASSWORD="SUPER_SECURE_PASSWORD_FOR_WEB_UI" # Modify

export PIHOLE_DOMAIN="pihole.example.com" # Modify

export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export METALLB_TRAEFIK_IP_ADDR="192.168.3.1" # Modify

export WILDCARD_CERTIFICATE_NAME="wildcard-example-com" # Modify

export TIMEZONE="Asia/Manila" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/default/dns-over-https/manifest.yml" > "${HOME}/.kube/manifests/default/dns-over-https.yaml"

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
