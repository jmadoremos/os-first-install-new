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
K3S_DATASTORE_EDP="mysql://username:password@tcp(127.0.0.1:3306)/kubernetes" # Modify

K3S_FIXED_REG_ADDR="k8s.example.com" # Modify

ansible-playbook "kubernetes/ansible/k3s-masters-install.ansible.yml" --extra-vars="k3s_datastore_edp=${K3S_DATASTORE_EDP} k3s_fixed_reg_addr=${K3S_FIXED_REG_ADDR}"
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
