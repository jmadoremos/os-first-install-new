# Kubernetes

## Installation

### Prepare Kubernetes Cluster

Install Ansible

```sh
curl -sfL "https://raw.githubusercontent.com/jmadoremos/os-first-install-new/main/linux/shared/scripts/ansible-install.sh" | bash
```

Install and configure pre-requisites

```sh
ansible-playbook "kubernetes/ansible/first-install.ansible.yml" --extra-vars "ansible_user=$(whoami)"
```

### Install and Setup Cluster Nodes

Primary Master Node

```sh
ansible-playbook "kubernetes/ansible/k3s-master-primary-install.ansible.yml"
```

Redundant Master Nodes

```sh
K3S_MASTER_URL="https://localhost:6443" # Modify

K3S_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

ansible-playbook "kubernetes/ansible/k3s-master-redundant-install.ansible.yml" --extra-vars="k3s_master_url=${K3S_MASTER_URL} k3s_token=${K3S_TOKEN}"
```

Local Worker Nodes

```sh
K3S_MASTER_URL="https://localhost:6443" # Modify

K3S_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

ansible-playbook "kubernetes/ansible/k3s-worker-local-install.ansible.yml" --extra-vars="k3s_master_url=${K3S_MASTER_URL} k3s_token=${K3S_TOKEN}"
```

Remote worker Nodes

```sh
K3S_MASTER_URL="https://k3s.example.com:6443" # Modify

K3S_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

ansible-playbook "kubernetes/ansible/k3s-worker-remote-install.ansible.yml" --extra-vars="k3s_master_url=${K3S_MASTER_URL} k3s_token=${K3S_TOKEN}"
```

### Setup MetalLB and Nginx

To follow.

## Pods Deployment

The pods deployment are handled by namespace:

* [Portainer](./namespaces/portainer/README.md)

* [Network Services](./namespaces/network-services/README.md)

* [Cert Manager](./namespaces/cert-manager/README.md)
