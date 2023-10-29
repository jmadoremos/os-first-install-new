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

> The domain `k8s.example.com` is set in dnsmasq.d with custom conf file containing `address=/k8s.example.com/MASTER_1_IP_ADDR` and `address=/k8s.example.com/MASTER_2_IP_ADDR` to load balance the master nodes.

Master Node

```sh
# For external DB
K3S_DATASTORE_EDP="mysql://username:password@tcp(127.0.0.1:3306)/kubernetes" # Modify

K3S_FIXED_REG_ADDR="k8s.example.com" # Modify

ansible-playbook "kubernetes/ansible/k3s-masters-install-externaldb.ansible.yml" --extra-vars="k3s_datastore_edp=${K3S_DATASTORE_EDP} k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR}"

# For etcd
K3S_FIXED_REG_ADDR="k8s.example.com" # Modify

ansible-playbook "kubernetes/ansible/k3s-masters-install-etcd.ansible.yml" --extra-vars="k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR}"
```

Local Worker Nodes

```sh
K3S_FIXED_REG_ADDR="k8s.example.com" # Modify

ansible-playbook "kubernetes/ansible/k3s-workers-local-install.ansible.yml" --extra-vars="k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR}"
```

Remote worker Nodes

```sh
K3S_FIXED_REG_ADDR="k8s.example.com" # Modify

ansible-playbook "kubernetes/ansible/k3s-workers-remote-install.ansible.yml" --extra-vars="k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR}"
```

Confirm Kubernetes nodes are responding

```sh
watch kubectl get nodes
```

[Optional] Install k9s to manage pods visually in the terminal.

```sh
curl -sS https://webinstall.dev/k9s | bash
```

### Setup Automated System Upgrade

Refer to [Automated System Update](./namespaces/system-upgrade/README.md) for the instructions.

### Setup Kubernetes CSI

* Synology CSI

  Refer to [Synology CSI](./namespaces/synology-csi/README.md) for the instructions.

* NFS

  Refer to [Kubernetes CSI (NFS)](./namespaces/default/kubernetes-csi-nfs/README.md) for the instructions.

* SMB/CIFS

  Refer to [Kubernetes CSI (SMB/CIFS)](./namespaces/default/kubernetes-csi-smb/README.md) for the instructions.

### Setup MetalLB

Refer to [MetalLB](./namespaces/metallb-system/README.md) for the instructions.

### Setup Cert Manager

Refer to [Cert Manager](./namespaces/cert-manager/README.md) for the instructions.

### Setup Traefik

Refer to [Traefik](./namespaces/kube-system/traefik/README.md) for the instructions.

## Pods Deployment

The pods deployment are handled by namespace:

* [DNS-over-HTTPS (DoH) service](./namespaces/default/dns-over-https/README.md)

* [Virtual Private Network (VPN) service](./namespaces/default/virtual-private-network/README.md)

* [Download Manager service](./namespaces/download-manager/README.md)

* [Quant UX](./namespaces/default/quant-ux/README.md)

For cluster monitoring:

* [Monitoring](./namespaces/monitoring/README.md)

For domain redirection to an IP address outside of the Kubernetes cluster:

* [External IP](./namespaces/default/external-ips/README.md)

## Troubleshooting

> Q: How to delete namespaces stuck in `Terminating` state?

Run this command:

```sh
NS=`kubectl get ns | grep Terminating | awk 'NR==1 {print $1}'` && kubectl get namespace "$NS" -o json | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" | kubectl replace --raw /api/v1/namespaces/$NS/finalize -f -
```

> Q: How to force recreate a deployment or stateful set?

Run this command:

```sh
# For deployment
kubectl rollout restart Deployment <deployment_name>

# For stateful set
kubectl rollout restart StatefulSet <stateful_set_name>
```

> Q: How to force delete a persistent volume or persistent volume claim?

1. Run this command:

```sh
# For persistent volume
kubectl edit pv <pv_name>

# For persistent volume claim
kubectl edit pvc <pvc_name>
```

2. Locate the following lines and delete them:

```markdown
finalizers:
  - kubernetes.io/pv-protection
```

3. Press `:` key then type `wq` to save and quit

4. Wait for the message `persistentvolume/<pv_name> edited`.

5. If the command fails, run the command mentioned in the error message to retry.

> Q: How to open a terminal with a container in a pod?

Run this command:

```sh
kubectl exec <pod_name> --container <container_name> -it -- /bin/bash

# or
kubectl exec <pod_name> --container <container_name> -it -- /bin/sh
```
