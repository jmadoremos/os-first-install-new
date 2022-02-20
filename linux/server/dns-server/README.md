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
ANSIBLE_HOST_IP="127.0.0.1"  # Modify with the IP address of the dns_server
ANSIBLE_USER_GID="1000" # Modify with the user's group id
ANSIBLE_USER_UID="1000" # Modify with the user's user id

ansible-playbook "linux/server/dns-server/ansible/dns-recursive-install.yml" --extra-vars "ansible_host_ip=$ANSIBLE_HOST_IP ansible_user_gid=$ANSIBLE_USER_GID ansible_user_uid=$ANSIBLE_USER_UID"
```

## Cleanup

1. Uninstall DNS

```sh
ansible-playbook "linux/server/dns-server/ansible/dns-recursive-uninstall.yml"
```

2. Unmount network share

```sh
ansible-playbook "linux/server/dns-server/ansible/media-unmount.yml"
```


## Frequently Asked Questions

> Pi-hole is reporting that there is an attempt to write to a read-only database.

Run the command to fix the problem. Taken from [Reddit](https://www.reddit.com/r/pihole/comments/owkao0/comment/hj1v0x0/?utm_source=share&utm_medium=web2x&context=3).

```sh
docker exec pihole chown -R www-data:pihole /etc/pihole
```
