#!/bin/bash

# Destroy psql_master
docker-compose --project-directory ../docker down

# Destroy master subvolume
btrfs subvolume delete /btrfs/psql_master
