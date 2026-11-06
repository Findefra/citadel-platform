#!/usr/bin/env bash
# 08-helm-release.sh
# Rollback a Helm release to previous or specific revision
# Usage: ./08-helm-release.sh <release> [namespace] [revision]

set -euo pipefail

RELEASE=${1:?Release name required}
NAMESPACE=${2:-default}
REVISION=${3:-}

echo "=== Helm Release Rollback ==="
echo "Release  : $RELEASE"
echo "Namespace: $NAMESPACE"
echo

helm history "$RELEASE" -n "$NAMESPACE"
echo

if [[ -z "$REVISION" ]]; then
  echo "Rolling back to previous revision..."
  helm rollback "$RELEASE" -n "$NAMESPACE"
else
  echo "Rolling back to revision $REVISION..."
  helm rollback "$RELEASE" "$REVISION" -n "$NAMESPACE"
fi

echo
helm status "$RELEASE" -n "$NAMESPACE"
