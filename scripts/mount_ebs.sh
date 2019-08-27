#!/usr/bin/env bash

echo "looking for nvme1n1"
while [ ! -b /dev/nvme1n1 ] ; do 
  echo -n .
  sleep 2
done

mkdir -p /mountdisk
blkid /dev/nvme1n1 || {
    mkfs.ext4 /dev/nvme1n1 -L mountdisk
}

grep LABEL=mountdisk /etc/fstab || {
  echo LABEL=mountdisk  /dev/nvme1n1 /mountdisk ext4 defaults,nofail 0 2 >> /etc/fstab
}

mountpoint /mountdisk || mount -L mountdisk /mountdisk

echo "looking for nvme2n1"
while [ ! -b /dev/nvme2n1 ] ; do 
  echo -n .
  sleep 2
done

mkdir -p /var/lib/replicated/snapshots
blkid /dev/nvme2n1 || {
    mkfs.ext4 /dev/nvme2n1 -L snapshots
}

grep LABEL=snapshots /etc/fstab || {
  echo LABEL=snapshots /dev/nvme2n1 /var/lib/replicated/snapshots ext4 defaults,nofail 0 2 >> /etc/fstab
}

mountpoint /var/lib/replicated/snapshots || mount -L snapshots /var/lib/replicated/snapshots
