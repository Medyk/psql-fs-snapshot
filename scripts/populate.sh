#!/bin/bash

PORT="${1:-5432}"
COUNT="${2:-1000000}"

echo "PORT ${PORT}"
psql "postgresql://postgres:postgres@localhost:${PORT}/postgres" -c "\dt"
psql "postgresql://postgres:postgres@localhost:${PORT}/postgres" -c "INSERT INTO random_data (value) SELECT gen_random_uuid() FROM generate_series(1, ${COUNT});"
psql "postgresql://postgres:postgres@localhost:${PORT}/postgres" -c "SELECT count(1) FROM random_data;"
