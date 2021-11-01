#!/bin/bash

export $(grep -v '^#' ../docker/.env | xargs)
PORT="$1"

# Destroy clone
docker rm -f "${COMPOSE_PROJECT_NAME}_psql_clone_${PORT}"

# Destroy snapshot
btrfs subvolume delete "/btrfs/psql_clone_${PORT}"
