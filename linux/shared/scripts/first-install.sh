#!/bin/bash

# Define color schemes
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_NONE='\033[0m'
DONE="${COLOR_GREEN}DONE${COLOR_NONE}"
FAILED="${COLOR_RED}FAILED${COLOR_NONE}"
SKIPPED="${COLOR_GREEN}SKIPPED${COLOR_NONE}"

# Add the current user as no password sudoers
echo -n "Installing dedicated sudoer file for $(whoami)..."
if [[ -f "/etc/sudoers.d/$(whoami)" ]]
then
    echo -e " $SKIPPED"
else
    echo "$(whoami)  ALL=(ALL)  NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$(whoami)" &> /dev/null
    [[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"
fi

# Update the operating system
echo -n "Running apt-get update..."
sudo apt-get update &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Running apt-get dist-upgrade..."
sudo apt-get dist-upgrade -y &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Running apt-get autoclean..."
sudo apt-get autoclean &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Running apt-get autoremove..."
sudo apt-get autoremove -y &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

# Install additional packages
echo -n "Installing pre-requisite software..."
sudo apt-get install -y git htop zsh &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Setting zsh as default shell pre-requisite software..."
sudo chsh -s /bin/zsh &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Installing \"oh-my-zsh\"..."
if [[ ! -f "${HOME}/.oh-my.zsh" ]]
then
    echo -e " $SKIPPED"
else
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" &> /dev/null
    [[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"
fi

# Reboot the system
echo "Rebooting system in 10 seconds..."
sleep 10
sudo reboot
