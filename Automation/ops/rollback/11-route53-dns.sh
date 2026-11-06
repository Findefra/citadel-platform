#!/usr/bin/env bash
# 11-route53-dns.sh
# Apply a previously saved Route53 change batch (rollback)
# Usage: ./11-route53-dns.sh <hosted-zone-id> <change-batch.json>

set -euo pipefail

HOSTED_ZONE_ID=${1:?Hosted Zone ID required}
CHANGE_BATCH_FILE=${2:?Previous change-batch JSON file required}

echo "=== Route53 DNS Rollback ==="
echo "Hosted Zone : $HOSTED_ZONE_ID"
echo "Change file : $CHANGE_BATCH_FILE"
echo

aws route53 change-resource-record-sets \
  --hosted-zone-id "$HOSTED_ZONE_ID" \
  --change-batch "file://$CHANGE_BATCH_FILE"

echo "DNS change submitted. Propagation may take up to 60s (or longer for some TTLs)."
