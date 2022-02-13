#!/bin/bash

# Define color schemes
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_NONE='\033[0m'
DONE="${COLOR_GREEN}DONE${COLOR_NONE}"
FAILED="${COLOR_RED}FAILED${COLOR_NONE}"
SKIPPED="${COLOR_GREEN}SKIPPED${COLOR_NONE}"

# Remove host inventory from environment variables
unset ANSIBLE_INVENTORY

# Delete .ansible.cfg file in home
echo -n "Removing ~/.ansible.cfg..."
sudo rm -f ${HOME}/.ansible.cfg &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

# Delete .ansible directory in home
echo -n "Removing ~/.ansible..."
sudo rm -rf ${HOME}/.ansible &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $SKIPPED"

# Uninstall ansible
echo -n "Uninstalling ansible..."
sudo apt-get remove -y ansible &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Running apt-get autoclean..."
sudo apt-get autoclean &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"

echo -n "Running apt-get autoremove..."
sudo apt-get autoremove -y &> /dev/null
[[ $? -eq 0 ]] && echo -e " $DONE" || echo -e " $FAILED"
