#!/usr/bin/env bash

sudo mkdir /mountdisk
sudo mkfs -t ext4 /dev/nvme1n1
sudo mount /dev/nvme1n1 /mountdisk
sudo echo /dev/nvme1n1 /mountdisk defaults,nofail 0 2 >> /etc/fstab

sudo mkdir -p /var/lib/replicated/snapshots
sudo mkfs -t ext4 /dev/nvme2n1
sudo mount /dev/nvme2n1 /var/lib/replicated/snapshots
sudo echo /dev/nvme2n1 /var/lib/replicated/snapshots defaults,nofail 0 2 >> /etc/fstab