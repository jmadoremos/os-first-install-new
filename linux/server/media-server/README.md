# Linux | Ansible for Media Server

## Installation

1. Mount network share

```sh
NETWORK_STORAGE_IP="127.0.0.1" # Modify with the IP address of the network_storage

ansible-playbook "linux/server/media-server/ansible/media-mount.yml" --extra-vars "network_storage_ip=${NETWORK_STORAGE_IP}"
```

2. Install Plex Media Server

```sh
ansible-playbook "linux/server/media-server/ansible/plex-install.yml"
```
