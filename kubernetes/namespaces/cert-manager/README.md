# Kubernetes | Pods Deployment for Cert Manager

## Installation

Set certificate request details

```sh
ACME_OWNER_EMAIL=""

AZR_SUBSCRIPTION=""

AZR_RESOURCE=""

AZR_DNS_ZONE=""

AZR_DOMAIN=""

AZR_SERVICE_PRINCIPAL_TENANT=""

AZR_SERVICE_PRINCIPAL_CLIENT=""

AZR_SERVICE_PRINCIPAL_SECRET=""
```

Create namespace

```sh
CERT_MANAGER_VERSION=v1.6.1

POD_NAMESPACE="cert-manager"

kubectl create namespace $POD_NAMESPACE

kubectl label namespaces $POD_NAMESPACE io.portainer.kubernetes.namespace.system=true
```

Create core pods

```sh
kubectl apply -n $POD_NAMESPACE -f "https://github.com/jetstack/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml"
```

Create Kubernetes manifests in home directory

```sh
mkdir ${HOME}/.k8s/manifests/cert-manager -m 640
```

Duplicate domain.yaml to home directory

```sh
cp "kubernetes/namespaces/cert-manager/manifests/domain.yaml" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"

sed -i "s/\[AZ_SUB\]/${AZR_SUBSCRIPTION}/" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"

sed -i "s/\[AZ_DNS_ZONE\]/${AZR_DNS_ZONE}/" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"

sed -i "s/\[AZ_SP_TENANT\]/${AZR_SERVICE_PRINCIPAL_TENANT}/" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"

sed -i "s/\[AZ_SP_CLIENT\]/${AZR_SERVICE_PRINCIPAL_CLIENT}/" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"

sed -i "s/\[AZ_SP_SECRET\]/${AZR_SERVICE_PRINCIPAL_SECRET}/" "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

### Portainer

Create certificate secrets

```sh
kubectl apply -n portainer -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Duplicate portainer.yaml

```sh
cp "kubernetes/namespaces/cert-manager/manifests/portainer.yaml" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[ACME_OWNER_EMAIL\]/${ACME_OWNER_EMAIL}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[AZ_RES_GRP\]/${AZR_RESOURCE}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[AZR_DOMAIN\]/${AZR_DOMAIN}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[AZ_SUB\]/${AZR_SUBSCRIPTION}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[AZ_SP_TENANT\]/${AZR_SERVICE_PRINCIPAL_TENANT}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

sed -i "s/\[AZ_SP_CLIENT\]/${AZR_SERVICE_PRINCIPAL_CLIENT}/" "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"
```

Create certificates and endpoints

```sh
kubectl apply -f "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"
```

### Network Services

Create certificate secrets

```sh
POD_NAMESPACE="network-services"

kubectl apply -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Install pihole certificate

```sh
cp "kubernetes/namespaces/cert-manager/manifests/pihole.yaml" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[ACME_OWNER_EMAIL\]/${ACME_OWNER_EMAIL}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[AZ_RES_GRP\]/${AZR_RESOURCE}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[AZR_DOMAIN\]/${AZR_DOMAIN}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[AZ_SUB\]/${AZR_SUBSCRIPTION}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[AZ_SP_TENANT\]/${AZR_SERVICE_PRINCIPAL_TENANT}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

sed -i "s/\[AZ_SP_CLIENT\]/${AZR_SERVICE_PRINCIPAL_CLIENT}/" "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"
```

Create certificates and endpoints

```sh
kubectl apply -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"
```

### Media Services

Create certificate secrets

```sh
POD_NAMESPACE="media-services"

kubectl apply -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Install plex certificate

```sh
cp "kubernetes/namespaces/cert-manager/manifests/plex.yaml" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[ACME_OWNER_EMAIL\]/${ACME_OWNER_EMAIL}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[AZ_RES_GRP\]/${AZR_RESOURCE}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[AZR_DOMAIN\]/${AZR_DOMAIN}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[AZ_SUB\]/${AZR_SUBSCRIPTION}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[AZ_SP_TENANT\]/${AZR_SERVICE_PRINCIPAL_TENANT}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

sed -i "s/\[AZ_SP_CLIENT\]/${AZR_SERVICE_PRINCIPAL_CLIENT}/" "${HOME}/.k8s/manifests/cert-manager/plex.yaml"
```

Create certificates and endpoints

```sh
kubectl apply -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/plex.yaml"
```

## Cleanup

Uninstall media services certificates and endpoints

```sh
POD_NAMESPACE="media-services"

kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/cert-manager/plex.yaml"

kubectl delete --ignore-not-found=true -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Uninstall network services certificates

```sh
POD_NAMESPACE="network-services"

kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/cert-manager/pihole.yaml"

kubectl delete --ignore-not-found=true -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Uninstall portainer certificates

```sh
POD_NAMESPACE="portainer"

kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/cert-manager/portainer.yaml"

kubectl delete --ignore-not-found=true -n $POD_NAMESPACE -f "${HOME}/.k8s/manifests/cert-manager/domain.yaml"
```

Confirm all certificates and related resources are removed

```sh
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
```

Delete resources under and including the namespace cert-manager

```sh
CERT_MANAGER_VERSION=v1.6.1

POD_NAMESPACE="cert-manager"

kubectl delete --ignore-not-found=true -n $POD_NAMESPACE -f "https://github.com/jetstack/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml"

kubectl delete namespaces $POD_NAMESPACE
```
