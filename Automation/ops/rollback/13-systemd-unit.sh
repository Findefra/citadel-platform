#!/usr/bin/env bash
# 13-systemd-unit.sh
# Restore a systemd unit file from backup and restart the service
# Usage: ./13-systemd-unit.sh <unit-name> [backup-dir]

set -euo pipefail

UNIT=${1:?Unit name required (e.g. myapp.service)}
BACKUP_DIR=${2:-/etc/systemd/system/backup}

echo "=== Systemd Unit Rollback ==="
echo "Unit       : $UNIT"
echo "Backup dir : $BACKUP_DIR"
echo

LATEST=$(ls -t "$BACKUP_DIR"/"${UNIT}".* 2>/dev/null | head -1 || true)

if [[ -z "$LATEST" ]]; then
  echo "ERROR: No backup unit found for $UNIT"
  exit 1
fi

echo "Restoring from: $LATEST"

cp -a "/etc/systemd/system/$UNIT" "/etc/systemd/system/${UNIT}.pre-rollback.$(date +%s)" 2>/dev/null || true
cp -a "$LATEST" "/etc/systemd/system/$UNIT"

systemctl daemon-reload
systemctl restart "$UNIT"
systemctl status "$UNIT" --no-pager
