#!/usr/bin/env bash
# 04-db-migration.sh
# Example Flyway-style database migration rollback
# Adapt for Liquibase, Alembic, Django, etc.
# Usage: ./04-db-migration.sh <target-version> [env]

set -euo pipefail

TARGET_VERSION=${1:?Target version required (e.g. 1.2.3)}
ENV=${2:-prod}

echo "=== Database Migration Rollback ==="
echo "Target version: $TARGET_VERSION"
echo "Environment   : $ENV"
echo

# Require DATABASE_URL or similar to be set
: "${DATABASE_URL:?DATABASE_URL must be set}"

TS=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="backup-pre-rollback-$TS.sql.gz"

echo "Taking database backup → $BACKUP_FILE"
pg_dump "$DATABASE_URL" | gzip > "$BACKUP_FILE"
echo "Backup complete."
echo

echo "Running Flyway undo to $TARGET_VERSION..."
flyway -configFiles="flyway-$ENV.conf" undo -target="$TARGET_VERSION"

echo
echo "Migration rolled back. Verify application compatibility immediately."
