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

### Setup MetalLB

1. Copy the /etc/rancher/k3s/k3s.yaml file from one of the master nodes to ~/.kube/config of the host.

2. Edit ~/.kube/config and replace `127.0.0.1` with the IP address of the load balancer of the master nodes or the IP address of one of the master nodes.

3. Check if all master nodes will appear.

```sh
kubectl get nodes
```

4. Apply the MetalLB manifest.

> This uses MetalLB v0.13.9. Update to the latest config when possible.

```sh
mkdir -p ~/.kube/manifests

curl https://raw.githubusercontent.com/metallb/metallb/v0.13.9/config/manifests/metallb-native.yaml --output ~/.kube/manifests/metallb-native.yaml

kubectl apply -f ~/.kube/manifests/metallb-native.yaml
```

5. Wait for the MetalLB pods to be created.

> There should be no output for the command below.

```sh
kubectl get pods --namespace metallb-system | grep "ContainerCreating"
```

6. Apply the MetalLB pool.

> Replace the range `127.0.0.1-127.0.0.2` with the IP addresses of the master node

```sh
kubectl apply -f "kubernetes/namespaces/metallb-system/k3s-server-pool.yml"
```

7. Test a web deployment.

```sh
kubectl create deploy nginx --image=nginx

kubectl expose deploy nginx --port=80 --target-port=80 --type=LoadBalancer

kubectl get all
```

8. Clean up the web deployment.

```sh
kubectl delete deploy nginx

kubectl delete svc nginx

kubectl get all
```

* Clean up everything

```sh
kubectl delete -f "kubernetes/namespaces/metallb-system/k3s-server-pool.yml"
```

### Setup Synology CSI

1. Build and install Synology CSI driver

```sh
DRIVER_VERSION="release-v1.1.1"

ansible-playbook "kubernetes/ansible/k3s-nodes-synology-csi-install.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```

2. Check the status of all pods

```sh
kubectl get pods --namespace synology-csi
```

3. Create secret, if needed as it is usually done by step #1 already

```sh
kubectl get secrets -n synology-csi

kubectl create secret -n synology-csi generic client-info-secret --from-file="kubernetes/namespaces/synology-csi/client-info.yml"

kubectl describe Secret client-info-secret -n synology-csi

kubectl get secret client-info-secret -n synology-csi -o json | jq -r '.data."client-info.yml"' | base64 --decode
```

4. Create the desired storage class. Step #1 already creates a temp storage class which must be removed to properly configure the resource.

```sh
kubectl delete -f "kubernetes/namespaces/synology-csi/synology-iscsi-storage.yml"

kubectl apply -f "kubernetes/namespaces/synology-csi/synology-iscsi-storage.yml"

kubectl describe StorageClass synology-iscsi-storage -n synology-csi
```

5. Create a PVC to test the storage configuration

```sh
kubectl apply -f "kubernetes/namespaces/synology-csi/test-persistent-volume-claim.yml"

kubectl describe PersistentVolumeClaim test-persistent-volume-claim
```

6. Clean up testing resources

```sh
kubectl delete -f "kubernetes/namespaces/synology-csi/test-persistent-volume-claim.yml"
```

* Clean up everything

```sh
ansible-playbook "kubernetes/ansible/k3s-nodes-synology-csi-uninstall.ansible.yml"
```

### Setup Kubernetes CSI

1. Build and install Synology CSI driver

```sh
DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/k3s-nodes-kubernetes-csi-install.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"

kubectl -n kube-system get pod -o wide -l app=csi-smb-controller

kubectl -n kube-system get pod -o wide -l app=csi-smb-node
```

2. Create secrets

```sh
SMB_USERNAME="username" # Modify

SMB_PASSWORD="password" # Modify

kubectl create secret generic csi-smb-credentials --from-literal username=$SMB_USERNAME --from-literal password="$SMB_PASSWORD"

kubectl describe Secret csi-smb-credentials

kubectl get secret csi-smb-credentials -o json | jq -r '.data.username' | base64 --decode

kubectl get secret csi-smb-credentials -o json | jq -r '.data.password' | base64 --decode
```

3. Create storage class

```sh
kubectl apply -f "kubernetes/namespaces/default/csi-smb-storage.yml"

kubectl describe StorageClass csi-smb-storage
```

4. Create a PVC to test the storage configuration

```sh
kubectl apply -f "kubernetes/namespaces/default/csi-smb-test-pvc.yml"

kubectl describe PersistentVolumeClaim csi-smb-test-pvc
```

5. Clean up testing resources

```sh
kubectl delete -f "kubernetes/namespaces/default/csi-smb-test-pvc.yml"
```

* Clean up everything

```sh
kubectl delete -f "kubernetes/namespaces/default/csi-smb-storage.yml"

kubectl delete secret csi-smb-credentials

DRIVER_VERSION="v1.10.0"

ansible-playbook "kubernetes/ansible/k3s-nodes-kubernetes-csi-uninstall.ansible.yml" --extra-vars="driver_version=${DRIVER_VERSION}"
```

## Pods Deployment

The pods deployment are handled by namespace:

* [Portainer](./namespaces/portainer/README.md)

* [Network Services](./namespaces/network-services/README.md)

* [Cert Manager](./namespaces/cert-manager/README.md)

* DNS-over-HTTPS (DoH)

  Creates a DNS service with DoH enabled using [DNSCrypt](https://dnscrypt.info) and [Pi-hole](https://pi-hole.net).

  > This is deployed to the `default` namespace.

  1. Create the folder where the local copy will be stored.

  ```sh
  mkdir -p "${HOME}/.k8s/manifests/default"
  ```

  2. Copy the manifest to the created folder.

  ```sh
  cat "kubernetes/namespaces/default/dns-over-https.yml" | tee "${HOME}/.k8s/manifests/default/dns-over-https.yaml"
  ```

  3. Replace the placeholders with the desired values.

  ```sh
  PIHOLE_CIDR="192.168.1.0/24" # Modify

  PIHOLE_GATEWAY="192.168.1.1" # Modify

  PIHOLE_TIMEZONE="Asia/Manila" # Modify

  PIHOLE_PASSWORD="SUPER_SECURE_PASSWORD_FOR_WEB_UI" # Modify

  sed -i "s|\[PIHOLE_CIDR\]|${PIHOLE_CIDR}|g" "${HOME}/.k8s/manifests/default/dns-over-https.yaml"

  sed -i "s|\[PIHOLE_GATEWAY\]|${PIHOLE_GATEWAY}|g" "${HOME}/.k8s/manifests/default/dns-over-https.yaml"

  sed -i "s|\[PIHOLE_TIMEZONE\]|${PIHOLE_TIMEZONE}|g" "${HOME}/.k8s/manifests/default/dns-over-https.yaml"

  sed -i "s|\[PIHOLE_PASSWORD\]|${PIHOLE_PASSWORD}|g" "${HOME}/.k8s/manifests/default/dns-over-https.yaml"

  cat "${HOME}/.k8s/manifests/default/dns-over-https.yaml"
  ```

  4. Run the deployment.

  ```sh
  kubectl apply -f "${HOME}/.k8s/manifests/default/dns-over-https.yaml"
  ```

  Remove the deployment.

  ```sh
  kubectl delete --ignore-not-found=true -f "${HOME}/.k8s/manifests/default/dns-over-https.yaml"
  ```

