# Enable Windows Subsystem for Linux
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Set WSL v2 as default
wsl --set-default-version 2

# Install Debian distro in Windows Subsystem for Linux
wsl --install -d Debian

# Set Debian as default distro
wsl --set-default Debian

# Login to wsl to setup credentials
wsl

# Create sudoer file for the current user
wsl -- echo "$(whoami)  ALL=(ALL)  NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$(whoami)"

# Update the system
wsl -- sudo apt update

wsl -- sudo apt dist-upgrade -y

# Install python3 and pip3
wsl -- sudo apt install -y python3 python3-pip

# Update WSL (requires administrative right)
wsl --update

wsl --shutdown
