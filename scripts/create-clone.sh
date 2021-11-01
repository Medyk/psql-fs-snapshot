#!/bin/bash

PORT="$1"

# FIXME: start backup and stop backup for snapshot
# Stop psql_master
docker-compose --project-directory ../docker stop psql_master

# Create snapshot
btrfs subvolume snapshot /btrfs/psql_master "/btrfs/psql_clone_${PORT}"

# Start psql_master
docker-compose --project-directory ../docker start psql_master

# Create new clone
export $(grep -v '^#' ../docker/.env | xargs)
docker run \
    --name "psql_clone_${PORT}" \
    -p ${PORT}:5432 \
    -v ${BTRFS_ROOT:-/btrfs}/psql_clone_${PORT}/data:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postgres} \
    --restart=always \
    --shm-size=64M \
    --network=psql-fs-snapshot_default \
    postgres:${DOCKER_IMAGE_POSTGRES_TAG:-latest}
