#!/bin/bash

# https://github.com/deoren/config-files
# https://gist.github.com/deoren/4d87ff5ddc831a22be433607341e5441

# Purpose: Perform initial setup for an Ubuntu VM running within Hyper-V environment

BASE_SRC_PATH="/tmp/config-files/ubuntu/all"

sudo apt-get update
sudo apt-get install -y git

cd /tmp
git clone https://github.com/deoren/config-files

sudo cp -vf ${BASE_SRC_PATH}/apt/sources.list.template /etc/apt/
sudo sed -i "s/CODENAME_PLACEHOLDER/$(lsb_release -c | awk '{print $2}')/g" /etc/apt/sources.list

sudo cp -vf ${BASE_SRC_PATH}/apt.conf.d/99force-ipv4 /etc/apt/apt.conf.d/

sudo apt-get update

# TODO: Check for Ubuntu 16.04. Install these packages. If newer, use next line
sudo apt-get install \
    linux-virtual-lts-xenial \
    linux-tools-virtual-lts-xenial \
    linux-cloud-tools-virtual-lts-xenial

# sudo apt-get install \
    # linux-image-virtual \
    # linux-tools-virtual \
    # linux-cloud-tools-virtual


sudo cp -vf ${BASE_SRC_PATH}/etc/default/grub /etc/default/grub
sudo update-grub

# Install other common packages?
# sudo apt-get install subversion tmux
