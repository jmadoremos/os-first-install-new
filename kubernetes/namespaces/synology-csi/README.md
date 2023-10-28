# Synology CSI

1. Install Synology CSI driver

```sh
# Create temp directory
mkdir -p "${HOME}/.kube/tmp"

# Define Synology DSM values
export SYN_DSM_IPV4_OR_DOMAIN="127.0.0.1" # Modify
export SYN_DSM_PORT="5000" # Modify
export SYN_DSM_HTTPS="false" # Modify
export SYN_DSM_USERNAME="smb_user" # Modify
export SYN_DSM_PASSWORD="SUPER_SECURE_PASSWORD_FOR_SMB" # Modify

# Create local copy of Synology CSI config with values applied
envsubst < "kubernetes/res/synology-csi-client-info.yml" > "${HOME}/.kube/tmp/synology-csi-client-info.yml"

# Run playbook
ansible-playbook "kubernetes/ansible/synology-csi-install.ansible.yml"

# Check status
watch kubectl get --namespace synology-csi pods
```

* Clean up everything

```sh
ansible-playbook "kubernetes/ansible/synology-csi-uninstall.ansible.yml"
```
