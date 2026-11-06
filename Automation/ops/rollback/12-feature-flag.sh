#!/usr/bin/env bash
# 12-feature-flag.sh
# Generic feature-flag / config-service rollback example
# Adapt the endpoint, auth, and payload to your system (LaunchDarkly, AppConfig, custom, etc.)
# Usage: ./12-feature-flag.sh <flag-key> <previous-value>

set -euo pipefail

FLAG_KEY=${1:?Flag key required}
PREVIOUS_VALUE=${2:?Previous value required}

: "${CONFIG_API_URL:?CONFIG_API_URL must be set}"
: "${CONFIG_TOKEN:?CONFIG_TOKEN must be set}"

echo "=== Feature Flag / Config Rollback ==="
echo "Flag  : $FLAG_KEY"
echo "Value : $PREVIOUS_VALUE"
echo

curl -sS -X PUT "${CONFIG_API_URL}/flags/${FLAG_KEY}" \
  -H "Authorization: Bearer ${CONFIG_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"value\": \"${PREVIOUS_VALUE}\"}"

echo
echo "Flag updated."
