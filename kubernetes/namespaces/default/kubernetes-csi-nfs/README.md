# Kubernetes CSI (NFS)

1. Build and install Kubernetes CSI driver for NFS share

> When there is a `failed` status in `Install Kubernetes CSI driver` step, as long as one of the nodes reported `ok` then continue. Otherwise, try again.

```sh
DRIVER_VERSION="v4.2.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-nfs-install.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"

# Check status
kubectl --namespace kube-system get pod -o wide -l app=csi-nfs-controller

kubectl --namespace kube-system get pod -o wide -l app=csi-nfs-node
```

2. Create the storage class

```sh
mkdir -p "${HOME}/.k8s/manifests/default"

cat "kubernetes/namespaces/default/kubernetes-csi-nfs/csi-nfs-storage.yml" | tee "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

NFS_HOST="127.0.0.1" # Modify

NFS_SHARE="/volume1/share" # Modify

sed -i "s|\[NFS_HOST\]|${NFS_HOST}|g" "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

sed -i "s|\[NFS_SHARE\]|${NFS_SHARE}|g" "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

cat "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

kubectl apply -f "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

# Check status
kubectl describe StorageClass csi-nfs-storage
```

3. Test the storage configuration

```sh
kubectl apply -f "kubernetes/namespaces/default/kubernetes-csi-nfs/csi-nfs-test-pvc.yml"

# Check status
kubectl describe PersistentVolumeClaim csi-nfs-test-pvc

# Check controller logs for any error
kubectl logs --selector app=csi-nfs-controller --namespace kube-system -c nfs

kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/kubernetes-csi-nfs/csi-nfs-test-pvc.yml"
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

DRIVER_VERSION="v4.2.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-nfs-uninstall.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```
