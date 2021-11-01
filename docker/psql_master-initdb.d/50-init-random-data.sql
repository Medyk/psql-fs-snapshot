CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE IF NOT EXISTS "random_data" (
    "id" bigserial PRIMARY KEY,
    "value" uuid NOT NULL DEFAULT gen_random_uuid()
);

INSERT INTO "random_data" ("value")
    SELECT gen_random_uuid() FROM generate_series(1, 5000000);
