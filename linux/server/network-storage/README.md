# Linux | Ansible for Network Storage

## Installation

1. Install and configure pre-requisites

```sh
ansible-playbook "linux/server/network-storage/ansible/first-install.yml" --extra-vars "ansible_user=$(whoami)"
```

2. Install Open Media Vault

```sh
mkdir ${HOME}/Downloads

wget "https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install" -O "${HOME}/Downloads/omv-install"

chmod +x ${HOME}/Downloads/omv-install

sudo ${HOME}/Downloads/omv-install
```

## Configuration

1. Navigate to Open Media Vault - Workbench

2. Login to admin using the default credentials:

  * Username: admin

  * Password: openmediavault

### Setup workbench

1. Go to "System" > "Workbench" page

2. Populate the fields as follows:

  * Port: 8080

  * Auto Logout: Disabled

3. Click the "Save" button

4. Go to "System" > "Update Management" > "Updates" page

5. Click the "Check for new updates" button

6. Click the "Download updates" button

7. Apply changes

## Setup network configurations

> Never update the hostname after Open Media Vault has been installed and configured. Changing the hostname may cause unintentional and unrecoverable issues.

1. Go to "Network" > "Interfaces" page

2. Click the primrary Ethernet network device (e.g., eth0)

3. Click the "Edit" button

4. Populate the fields as follows:

  * DNS Servers: 1.1.1.1,8.8.8.8

  * Wake-on-LAN: Yes

5. Click the "Save" button

6. Apply changes

### Setup a new user

1. Go to "Users" > "Users" page

2. Click the "Create | Import" button

3. Select the "Create" option

4. Populate the fields as follows:

  * Name: momonga

  * Password: [PASSWORD]

  * Shell: /bin/zsh

  * Groups: sambashare, ssh, sudo, users

  * SSH public keys: [SSH PUBLIC KEYS]

  * Disallow account modification: Yes

5. Click the "Save" button

6. Apply changes

### Setup file system

1. Go to "Storage" > "File Systems" page

2. Click the "Create | Mount" button

3. Select the "Mount" option

4. Populate as follows:

  * File system: [UNMOUNTED FILE SYSTEM]

  * Comment: [LABEL FOR FILE SYSTEM]

5. Click the "Save" button

6. Repeat #2 to #5 for other file systems to mount

7. Go to "Storage" > "Shared Folders" page

8. Click the "Create" button

9. Populate the fields as follows:

  * Name: [NAME OF SHARED FOLDER]

  * File system: [SOURCE FILE SYSTEM]

  * Relative path: [PATH FOR SHARED FOLDER]

  * Permissions: [PERMISSION FOR SHARED FOLDER]

10. Click the "Save" button

11. Repeat #8 to #10 for other shared folders to create

12. Apply changes

### Setup the services

1. Go to "Services" > "NFS" > "Settings" page

2. Populate the fields as follows:

  * Enabled: Yes

3. Click the "Save" button

4. Go to "Services" > "NFS" > "Shares" page

5. Click the "Create" button

6. Populate the fields as follows:

  * Shared folder: [SHARED FOLDER TO EXPOSE]

  * Client: [CIDR OF LOCAL NETWORK]

  * Privilege: [PERMISSION OF SHARED FOLDER]

  * Extra options: [INCLUDE `no_root_squash` FOR PUBLICLY ACCESSIBLE MOUNTS]

7. Click the "Save" button

8. Repeat #5 to #7 for other shared folders to expose

9. Go to "Services" > "SMB/CIFS" > "Settings" page

10. Populate the fields as follows:

  * Enabled: Yes

  * Extra options:

    ```
    server min protocol = SMB2
    min receivefile size = 16384
    write cache size = 524288
    getwd cache = yes
    socket options = TCP_NODELAY IPTOS_LOWDELAY
    aio write behind = true
    aio read size = 16384
    aio write size = 16384
    ```

11. Click the "Save" button

12. Go to "Services" > "SSH" page

13. Populate the fields as follows:

  * Enabled: Yes

  * Permit root login: No

  * Password authentication: No

  * Public key authentication: Yes

  * TCP Forwarding: Yes

14. Click the "Save" button

15. Apply changes
