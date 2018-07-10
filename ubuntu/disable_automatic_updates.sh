#!/bin/bash

# https://github.com/deoren/config-files


# Goal:
#
#  Stop Ubuntu test VM from attempting to sync apt repos upon initial boot
#  (which ends up locking the dpkg database). This behavior forces me to wait
#  before I can run apt from a test script.

for unit in unattended-upgrades apt-daily-upgrade.timer apt-daily.timer
do
    sudo systemctl disable $unit
    sudo systemctl stop $unit
done



# This doesnt' seem to do anything, so disabling
# sudo systemctl disable apt-daily.service
# sudo systemctl disable apt-daily-upgrade.service

# root@ubuntu-1604-virtual-machine:~# systemctl list-unit-files | grep -iE 'apt|upgrade|update'
# systemd-networkd-resolvconf-update.path    static
# apt-daily-upgrade.service                  static
# apt-daily.service                          static
# fwupd-offline-update.service               static
# fwupdate-cleanup.service                   static
# systemd-hwdb-update.service                static
# systemd-networkd-resolvconf-update.service static
# systemd-update-utmp-runlevel.service       static
# systemd-update-utmp.service                static
# unattended-upgrades.service                disabled
# system-update.target                       static
# apt-daily-upgrade.timer                    disabled
# apt-daily.timer                            disabled
