# Linux | Ansible for DNS Server

## Installation

1. Mount network share

```sh
NETWORK_STORAGE_IP="127.0.0.1" # Modify with the IP address of the network_storage

ansible-playbook "linux/server/dns-server/ansible/media-mount.yml" --extra-vars "network_storage_ip=${NETWORK_STORAGE_IP}"
```

2. Install one of the following:

* Recursive DNS

```sh
ansible-playbook "linux/server/dns-server/ansible/dns-recursive-install.yml" --extra-vars "ansible_user=$(whoami)"
```
