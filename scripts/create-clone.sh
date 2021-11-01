#!/bin/bash

export $(grep -v '^#' ../docker/.env | xargs)
PORT="$1"

# FIXME: start backup and stop backup for snapshot
# Stop psql_master
docker-compose --project-directory ../docker stop psql_master

# Create snapshot
btrfs subvolume snapshot /btrfs/psql_master "/btrfs/psql_clone_${PORT}"

# Start psql_master
docker-compose --project-directory ../docker start psql_master

# Create new clone
docker run \
    --name "${COMPOSE_PROJECT_NAME}_psql_clone_${PORT}" \
    --detach \
    -p ${PORT}:5432 \
    -v ${BTRFS_ROOT:-/btrfs}/psql_clone_${PORT}/data:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-postgres} \
    --restart=always \
    --shm-size=64M \
    --network=${COMPOSE_PROJECT_NAME}_default \
    postgres:${DOCKER_IMAGE_POSTGRES_TAG:-latest}
