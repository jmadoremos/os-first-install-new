# Cert Manager

cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.

1. Create the components using a release version from GitHub.

```sh
# Apply the manifest
CERT_MANAGER_VERSION="v1.12.1"

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

# Set customizations for the local copy
export CLOUDFLARE_API_TOKEN="API_TOKEN_FROM_CLOUDFLARE" # Modify

export CLOUDFLARE_EMAIL="john.doe@example.com" # Modify

export CLOUDFLARE_REGISTERED_DOMAIN="example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/cert-manager/acme-staging.yml" > "${HOME}/.kube/manifests/cert-manager/acme-staging/manifest.yaml"

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

# Set customizations for the local copy
export CLOUDFLARE_API_TOKEN="API_TOKEN_FROM_CLOUDFLARE" # Modify

export CLOUDFLARE_EMAIL="john.doe@example.com" # Modify

export CLOUDFLARE_REGISTERED_DOMAIN="example.com" # Modify

export WILDCARD_CERTIFICATE_NAME="wildcard-example-com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/cert-manager/acme-production.yml" > "${HOME}/.kube/manifests/cert-manager/acme-production/manifest.yaml"

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
