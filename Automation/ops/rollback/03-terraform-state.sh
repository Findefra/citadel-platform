#!/usr/bin/env bash
# 03-terraform-state.sh
# Restore a known-good terraform.tfstate (USE WITH EXTREME CAUTION)
# Usage: ./03-terraform-state.sh <path-to-good-state> [workspace]

set -euo pipefail

STATE_BACKUP=${1:?Path to known-good terraform.tfstate required}
WORKSPACE=${2:-default}

echo "=== Terraform State Rollback ==="
echo "WARNING: This will overwrite the current terraform.tfstate"
echo "Backup file : $STATE_BACKUP"
echo "Workspace   : $WORKSPACE"
echo

read -r -p "Type ROLLBACK to continue: " confirm
[[ "$confirm" == "ROLLBACK" ]] || { echo "Aborted."; exit 1; }

# Safety backup of current state
TS=$(date +%Y%m%d%H%M%S)
if [[ -f terraform.tfstate ]]; then
  cp -a terraform.tfstate "terraform.tfstate.pre-rollback.$TS"
  echo "Current state backed up to terraform.tfstate.pre-rollback.$TS"
fi

cp -a "$STATE_BACKUP" terraform.tfstate

terraform workspace select "$WORKSPACE" 2>/dev/null || true
echo
echo "State restored. ALWAYS run 'terraform plan' and review carefully before apply."
