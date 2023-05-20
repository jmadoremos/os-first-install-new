# Cert Manager

cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

1. Create the components using a release version from GitHub.

```sh
# Apply the manifest
CERT_MANAGER_VERSION="v1.11.2"

kubectl apply -f "https://github.com/cert-manager/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml"

# Verify installation
kubectl get --namespace cert-manager pods
```

2. Test the configuration.

```sh
# Test configuration by creating a self-signed certificate
kubectl apply -f "kubernetes/namespaces/cert-manager/cert-manager-test.yml"

kubectl get --namespace cert-manager-test certificate

# Clean up after testing is complete
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/cert-manager/cert-manager-test.yml"
```

3. Setup ACME staging.

```sh
mkdir -p "${HOME}/.kube/manifests/cert-manager/acme-staging"

# Create local copy of the manifest
cat "kubernetes/namespaces/cert-manager/acme-staging.yml" | tee "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

# Apply customizations to the local copy
CLOUDFLARE_API_TOKEN="API_TOKEN_FROM_CLOUDFLARE" # Modify

CLOUDFLARE_EMAIL="john.doe@example.com" # Modify

CLOUDFLARE_REGISTERED_DOMAIN="example.com" # Modify

sed -i "s|\[CLOUDFLARE_API_TOKEN\]|${CLOUDFLARE_API_TOKEN}|g" "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

sed -i "s|\[CLOUDFLARE_EMAIL\]|${CLOUDFLARE_EMAIL}|g" "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

sed -i "s|\[CLOUDFLARE_REGISTERED_DOMAIN\]|${CLOUDFLARE_REGISTERED_DOMAIN}|g" "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

cat "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

# Check status
CERT_MANAGER_POD_NAME=$(kubectl get --namespace cert-manager pods --selector "app.kubernetes.io/name=cert-manager,app.kubernetes.io/component=controller" --output=name)

kubectl logs --namespace cert-manager $CERT_MANAGER_POD_NAME

kubectl get challenges && kubectl get certificates

# Clean up staging
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

kubectl delete --ignore-not-found=true secret local-certificate-staging-tls

kubectl delete --ignore-not-found=true --namespace cert-manager secret letsencrypt-staging
```

4. Setup ACME Production.

```sh
mkdir -p "${HOME}/.kube/manifests/cert-manager/acme-production"

# Create local copy of the manifest
cat "kubernetes/namespaces/cert-manager/acme-production.yml" | tee "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

# Apply customizations to the local copy
CLOUDFLARE_API_TOKEN="API_TOKEN_FROM_CLOUDFLARE" # Modify

CLOUDFLARE_EMAIL="john.doe@example.com" # Modify

CLOUDFLARE_REGISTERED_DOMAIN="example.com" # Modify

WILDCARD_CERTIFICATE_NAME="wildcard-example-com" # Modify

sed -i "s|\[CLOUDFLARE_API_TOKEN\]|${CLOUDFLARE_API_TOKEN}|g" "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

sed -i "s|\[CLOUDFLARE_EMAIL\]|${CLOUDFLARE_EMAIL}|g" "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

sed -i "s|\[CLOUDFLARE_REGISTERED_DOMAIN\]|${CLOUDFLARE_REGISTERED_DOMAIN}|g" "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

sed -i "s|\[WILDCARD_CERTIFICATE_NAME\]|${WILDCARD_CERTIFICATE_NAME}|g" "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

cat "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

# Check status
kubectl get --namespace kube-system challenges && kubectl get --namespace kube-system certificates
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

CERT_MANAGER_VERSION="v1.11.2"

kubectl delete --ignore-not-found=true -f "https://github.com/cert-manager/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml"
```
