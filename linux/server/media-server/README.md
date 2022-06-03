# Linux | Ansible for Media Server

## Installation

1. Mount network share

```sh
STORAGE_SERVER_IP="127.0.0.1" # Modify with the IP address of the storage_server

ansible-playbook "linux/server/media-server/ansible/media-mount.yml" --extra-vars "storage_server_ip=${STORAGE_SERVER_IP}"
```

2. Install Plex Media Server

```sh
ansible-playbook "linux/server/media-server/ansible/plex-install.yml"
```

## Uninstall

1. Uninstall Plex Media Server

```sh
ansible-playbook "linux/server/media-server/ansible/plex-uninstall.yml"
```

2. Unmount network share

```sh
STORAGE_SERVER_IP="127.0.0.1" # Modify with the IP address of the storage_server

ansible-playbook "linux/server/media-server/ansible/media-unmount.yml" --extra-vars "storage_server_ip=${STORAGE_SERVER_IP}"
```