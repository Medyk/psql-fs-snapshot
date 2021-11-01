#!/bin/bash

btrfs-du /btrfs
docker ps --filter "name=psql-fs-snapshot" -a
