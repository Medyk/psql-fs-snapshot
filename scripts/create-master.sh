#!/bin/bash

# Create master subvolume
btrfs subvolume create /btrfs/psql_master

# Start psql_master
docker-compose --project-directory ../docker up -d
