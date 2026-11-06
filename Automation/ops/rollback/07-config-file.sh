#!/usr/bin/env bash
# 07-config-file.sh
# Restore a config file from the newest timestamped backup
# Usage: ./07-config-file.sh <config-file-path> [backup-dir]

set -euo pipefail

CONFIG_FILE=${1:?Config file path required}
BACKUP_DIR=${2:-/var/backups/configs}

echo "=== Config File Rollback ==="
echo "Target file : $CONFIG_FILE"
echo "Backup dir  : $BACKUP_DIR"
echo

BASENAME=$(basename "$CONFIG_FILE")
LATEST=$(ls -t "$BACKUP_DIR"/"$BASENAME".* 2>/dev/null | head -1 || true)

if [[ -z "$LATEST" ]]; then
  echo "ERROR: No backup found for $BASENAME in $BACKUP_DIR"
  exit 1
fi

echo "Restoring from: $LATEST"

# Safety copy of current file
cp -a "$CONFIG_FILE" "${CONFIG_FILE}.pre-rollback.$(date +%s)"
cp -a "$LATEST" "$CONFIG_FILE"

echo "Restored successfully."
echo "Reload or restart the related service if required (e.g. systemctl reload nginx)."
