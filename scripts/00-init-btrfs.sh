#!/bin/bash

# Init new logical volume on 'vg0'
lvcreate vg0 -L 10G -n lv-btrfs
mkfs.btrfs /dev/mapper/vg0-lv--btrfs

# Add /btrfs to fstab
echo -e "\n/dev/mapper/vg0-lv--btrfs /btrfs btrfs defaults 0 2\n" >> /etc/fstab
mount -a

# Create master subvolume
btrfs subvolume create /btrfs/psql_master
btrfs subvolume list /btrfs
