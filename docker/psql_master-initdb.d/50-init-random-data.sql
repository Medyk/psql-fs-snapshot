CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS "random_data" (
    "id" bigserial PRIMARY KEY,
    "value" uuid NOT NULL DEFAULT gen_random_uuid()
);

CREATE TABLE IF NOT EXISTS "random_data2" (
    "id" bigserial PRIMARY KEY,
    "value" uuid NOT NULL DEFAULT gen_random_uuid()
);

INSERT INTO "random_data" ("value")
    SELECT gen_random_uuid() FROM generate_series(1, 1000000);

INSERT INTO "random_data2" ("value")
    SELECT gen_random_uuid() FROM generate_series(1, 5000000);
