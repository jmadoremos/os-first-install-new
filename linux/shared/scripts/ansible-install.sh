#!/bin/bash

# Define color schemes
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_NONE='\033[0m'
DONE="${COLOR_GREEN}DONE${COLOR_NONE}"
FAILED="${COLOR_RED}FAILED${COLOR_NONE}"
SKIPPED="${COLOR_GREEN}SKIPPED${COLOR_NONE}"

# Install ansible
echo -n "Installing ansible and required packages..."
sudo apt-get install -y ansible git libffi-dev libssl-dev python3-pip python3-apt &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

# Create .ansible/ directory in home
echo -n "Creating ~/.ansible..."
mkdir ${HOME}/.ansible -m 770 &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $SKIPPED"

# Create .ansible/hosts/ directory in home
echo -n "Creating ~/.ansible/hosts..."
mkdir ${HOME}/.ansible/hosts -m 770 &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $SKIPPED"

# Create host inventory
echo -n "Creating ~/.ansible/hosts/servers..."
cat << EOF | tee ${HOME}/.ansible/hosts/servers &> /dev/null
servers:
  children:
    storage_server:
      hosts:
        alexandria:
          node_name: alexandria
          ansible_connection: local
          ansible_python_interpreter: /usr/bin/python3
          ansible_shell_executable: /bin/bash
    media_server:
      hosts:
        dionysus:
          node_name: dionysus
          ansible_connection: ssh
          ansible_python_interpreter: /usr/bin/python3
          ansible_shell_executable: /bin/bash
EOF
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Creating ~/.ansible/hosts/k8s_cluster..."
cat << EOF | tee ${HOME}/.ansible/hosts/k8s_cluster &> /dev/null
k8s_cluster:
  children:
    k8s_masters:
      children:
        k8s_master_primary:
          hosts:
            localhost:
              node_name: seraphimy
              ansible_connection: local
              ansible_python_interpreter: /usr/bin/python
              ansible_shell_executable: /bin/bash
        k8s_master_redundant:
          hosts:
            localhost:
              node_name: cheruvimy
              ansible_connection: local
              ansible_python_interpreter: /usr/bin/python
              ansible_shell_executable: /bin/bash
    k8s_workers:
      children:
        k8s_worker_local:
          hosts:
            sily-01:
              node_name: sily-01
              ansible_connection: local
              ansible_python_interpreter: /usr/bin/python
              ansible_shell_executable: /bin/bash
        k8s_worker_remote:
          hosts:
            localhost:
              node_name: vlasti-01
              ansible_connection: local
              ansible_python_interpreter: /usr/bin/python
              ansible_shell_executable: /bin/bash
EOF
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

# Create .ansible.cfg in home
echo -n "Creating ~/.ansible.cfg..."
cat << EOF | sudo tee ${HOME}/.ansible.cfg &> /dev/null
[defaults]
interpreter_python=/usr/bin/python3

[ssh_connection]
control_path=/tmp/%%h-%%p-%%r
EOF
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

# Set permissions for ~/.ansible.cfg
sudo chmod 640 ${HOME}/.ansible.cfg

# Add host inventory to environment variable
export ANSIBLE_INVENTORY=${HOME}/.ansible/hosts/

# Ping all hosts
ansible all -m ping
