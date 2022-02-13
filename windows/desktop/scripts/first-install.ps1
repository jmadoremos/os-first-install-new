# Install Debian distro in Windows Subsystem for Linux
wsl --install -d Debian

# Login to wsl to setup credentials
wsl

# Create sudoer file for the current user
wsl -- echo "$(whoami)  ALL=(ALL)  NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$(whoami)"

# Update the system
wsl -- sudo apt update

wsl -- sudo apt dist-upgrade -y

# Install python3 and pip3
wsl -- sudo apt install -y python3 python3-pip
