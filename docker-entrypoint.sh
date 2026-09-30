#!/bin/sh
set -e

echo "[entrypoint] Waiting for database..."
npx tsx backend/src/scripts/wait-and-init-db.ts

echo "[entrypoint] Running Prisma migrate deploy..."
npx prisma migrate deploy

echo "[entrypoint] Seeding database..."
npx tsx prisma/seed.ts || true

echo "[entrypoint] Starting server..."
exec npx tsx server.ts
