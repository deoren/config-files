#!/bin/bash

# https://github.com/deoren/config-files
# https://gist.github.com/deoren/4d87ff5ddc831a22be433607341e5441

# Purpose: Perform initial setup for an Ubuntu VM running within Hyper-V environment

BASE_SRC_PATH="/tmp/config-files/ubuntu/all"

UBUNTU_RELEASE="$(lsb_release -c | awk '{print $2}')"

sudo apt-get update
sudo apt-get install -y git

cd /tmp
git clone https://github.com/deoren/config-files

sudo cp -vf ${BASE_SRC_PATH}/etc/apt/sources.list.template /etc/apt/sources.list
sudo sed -i "s/CODENAME_PLACEHOLDER/${UBUNTU_RELEASE}/g" /etc/apt/sources.list

# Chosen mirrors default to IPv6, but attempts to use them usually fail
sudo cp -vf ${BASE_SRC_PATH}/etc/apt/apt.conf.d/99force-ipv4 /etc/apt/apt.conf.d/

sudo apt-get update

# Install "tools" packages to enable:
#
# VSS Snapshot daemon - This daemon is required to create live Linux virtual machine backups.
# KVP daemon - This daemon allows setting and querying intrinsic and extrinsic key value pairs.
# fcopy daemon - This daemon implements a file copying service between the host and guest.

if [[ "$UBUNTU_RELEASE" == "xenial" ]]; then

    # If a HWE kernel (newer than the base 4.4 or LTS kernel) is installed ...
    #if dpkg -l | grep -E '^ii' | grep linux-image | grep -Eq '4.(10|13|15)'
    if dpkg -l | grep -E '^ii' | grep linux-image | grep hwe
    then

        # Install matching "tools" packages to enable hv-fcopy-daemon operation
        sudo apt-get install \
            linux-virtual-hwe-16.04
            linux-cloud-tools-virtual-hwe-16.04 \
            linux-tools-virtual-hwe-16.04

    else

        # The 16.04 instance likely only has the original 4.4 LTS kernel,
        # so do not install the HWE-based kernel and "tools" packages
        sudo apt-get install \
            linux-virtual-lts-xenial \
            linux-tools-virtual-lts-xenial \
            linux-cloud-tools-virtual-lts-xenial

    fi

else

    # 17.04, 17.10, ...
    sudo apt-get install \
        linux-image-virtual \
        linux-tools-virtual \
        linux-cloud-tools-virtual

fi


# Override video resolution, tweak I/O settings, ...
sudo cp -vf ${BASE_SRC_PATH}/etc/default/grub /etc/default/grub
sudo update-grub

# Install other common packages?
# sudo apt-get install subversion tmux
