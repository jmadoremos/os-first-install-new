# Linux

## First Install

The script below runs a number of basic commands to prepare the server for succeeding installations.

```sh
curl -sfL "https://raw.githubusercontent.com/jmadoremos/os-first-install-new/main/linux/shared/scripts/first-install.sh" | bash
```

## Install Ansible

The script below runs commands to install and setup Ansible.

```sh
curl -sfL "https://raw.githubusercontent.com/jmadoremos/os-first-install-new/main/linux/shared/scripts/ansible-install.sh" | bash
```

## Additional Installation

Additional installation is required for servers with specific use-case. Proceed to the [Ansible Playbook for Servers](./server/README.md) to continue.


Other extra installations:

* Docker

```sh
ansible-playbook "/linux/shared/ansible/docker-install.yml" --extra-vars "ansible_user=$(whoami)"
```
