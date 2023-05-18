# Kubernetes

## Installation

### Prepare Kubernetes Cluster

Install Ansible

```sh
curl -sfL "https://raw.githubusercontent.com/jmadoremos/os-first-install-new/main/linux/shared/scripts/ansible-install.sh" | bash
```

Install and configure pre-requisites

```sh
ansible-playbook "kubernetes/ansible/first-install.ansible.yml"
```

### Install and Setup Cluster Nodes

Master Node

```sh
K3S_DATASTORE_EDP="mysql://username:password@tcp(127.0.0.1:3306)/kubernetes" # Modify

K3S_TOKEN=$(cat ~/.kube/token)

ansible-playbook "kubernetes/ansible/k3s-masters-install.ansible.yml" --extra-vars="k3s_datastore_edp=${K3S_DATASTORE_EDP} k3s_token=${K3S_TOKEN}"
```

Local Worker Nodes

```sh
K3S_FIXED_REG_ADDR="https://127.0.0.1:6443" # Modify

K3S_TOKEN=$(cat ~/.kube/token)

ansible-playbook "kubernetes/ansible/k3s-workers-local-install.ansible.yml" --extra-vars="k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR} k3s_token=${K3S_TOKEN}"
```

Remote worker Nodes

```sh
K3S_MASTER_URL="https://k3s.example.com:6443" # Modify

K3S_TOKEN=$(cat ~/.kube/token)

ansible-playbook "kubernetes/ansible/k3s-workers-remote-install.ansible.yml" --extra-vars="k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR} k3s_token=${K3S_TOKEN}"
```

### Setup host

1. Copy the /etc/rancher/k3s/k3s.yaml file from one of the master nodes to ~/.kube/config of the host.

2. Edit ~/.kube/config and replace `127.0.0.1` with the IP address of the load balancer of the master nodes or the IP address of one of the master nodes.

3. Check if all master nodes will appear.

```sh
kubectl get nodes
```

### Setup Kubernetes CSI

* NFS

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

cat "kubernetes/namespaces/default/csi-nfs-storage.yml" | tee "${HOME}/.k8s/manifests/default/csi-nfs-storage.yml"

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
kubectl apply -f "kubernetes/namespaces/default/csi-nfs-test-pvc.yml"

# Check status
kubectl describe PersistentVolumeClaim csi-nfs-test-pvc

# Check controller logs for any error
kubectl logs --selector app=csi-nfs-controller --namespace kube-system -c nfs

kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/csi-nfs-test-pvc.yml"
```

  * Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/csi-nfs-storage.yml"

DRIVER_VERSION="v4.2.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-nfs-uninstall.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```

* SMB/CIFS

  1. Build and install Kubernetes CSI driver for SMB/CIFS share

```sh
DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-smb-install.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"

# Check status
kubectl --namespace kube-system get pod -o wide -l app=csi-smb-controller

kubectl --namespace kube-system get pod -o wide -l app=csi-smb-node
```

  2. Create secrets

```sh
SMB_USERNAME="username" # Modify

SMB_PASSWORD="password" # Modify

kubectl create secret generic csi-smb-credentials --from-literal username=$SMB_USERNAME --from-literal password="$SMB_PASSWORD"

# Check status
kubectl describe Secret csi-smb-credentials

# Check secrets value
kubectl get secret csi-smb-credentials -o json | jq -r '.data.username' | base64 --decode

kubectl get secret csi-smb-credentials -o json | jq -r '.data.password' | base64 --decode
```

  3. Create storage class

```sh
kubectl apply -f "kubernetes/namespaces/default/csi-smb-storage.yml"

# Check status
kubectl describe StorageClass csi-smb-storage
```

  4. Create a PVC to test the storage configuration

```sh
kubectl apply -f "kubernetes/namespaces/default/csi-smb-test-pvc.yml"

# Check status
kubectl describe PersistentVolumeClaim csi-smb-test-pvc
```

  5. Clean up testing resources

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/csi-smb-test-pvc.yml"
```

  * Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "kubernetes/namespaces/default/csi-smb-storage.yml"

kubectl delete --ignore-not-found=true secret csi-smb-credentials

DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/kubernetes-csi-smb-uninstall.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```

### Setup MetalLB

Refer to [MetalLB](./namespaces/metallb-system/README.md) for the instructions.

### Setup Traefik

Refer to [Traefik](./namespaces/kube-system/traefik/README.md) for the instructions.

### Setup Cert Manager

Refer to [Cert Manager](./namespaces/cert-manager/README.md) for the instructions.

## Pods Deployment

The pods deployment are handled by namespace:

* [Portainer](./namespaces/portainer/README.md)

* [Network Services](./namespaces/network-services/README.md)

* [Cert Manager](./namespaces/cert-manager/README.md)

* [DNS-over-HTTPS (DoH) service](./namespaces/default/dns-over-https/README.md)
