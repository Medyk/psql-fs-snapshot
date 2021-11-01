#!/bin/bash

PORT="$1"

# Destroy clone
docker rm -f "psql_clone_${PORT}"

# Destroy snapshot
btrfs subvolume delete "/btrfs/psql_clone_${PORT}"
