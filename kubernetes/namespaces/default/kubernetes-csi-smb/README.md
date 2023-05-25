# Kubernetes CSI (SMB/CIFS)

1. Build and install Kubernetes CSI driver for SMB/CIFS share

```sh
DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-smb-install.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"

# Check status
kubectl --namespace kube-system get pod -o wide -l app=csi-smb-controller

kubectl --namespace kube-system get pod -o wide -l app=csi-smb-node
```

2. Setup the Kubernetes CSI configuration

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Set customizations for the local copy
export SMB_SHARE="//smb-server.default.svc.cluster.local/share" # Modify

export SMB_USERNAME="username" # Modify

export SMB_PASSWORD="password" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/default/kubernetes-csi-smb/csi-smb-storage.yml" > "${HOME}/.k8s/manifests/default/csi-smb-storage.yml"

cat "${HOME}/.k8s/manifests/default/csi-smb-storage.yml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.k8s/manifests/default/csi-smb-storage.yml"

# Check status
kubectl describe Secret csi-smb-credentials

kubectl describe StorageClass csi-smb-storage
```

3. Create a PVC to test the storage configuration

```sh
kubectl apply -f "kubernetes/namespaces/default/kubernetes-csi-smb/csi-smb-test-pvc.yml"

# Check status
kubectl describe PersistentVolumeClaim csi-smb-test-pvc
```

4. Clean up testing resources

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/kubernetes-csi-smb/csi-smb-test-pvc.yml"
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/default/csi-smb-storage.yml"

DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-smb-uninstall.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```
