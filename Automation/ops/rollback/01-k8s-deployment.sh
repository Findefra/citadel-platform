#!/usr/bin/env bash
# 01-k8s-deployment.sh
# Rollback a Kubernetes Deployment to previous (or specific) revision
# Usage: ./01-k8s-deployment.sh <namespace> <deployment> [revision]

set -euo pipefail

NS=${1:?Namespace required}
DEP=${2:?Deployment required}
REV=${3:-}

echo "=== Kubernetes Deployment Rollback ==="
echo "Namespace : $NS"
echo "Deployment: $DEP"
echo

kubectl rollout history deployment/"$DEP" -n "$NS"
echo

if [[ -z "$REV" ]]; then
  echo "Rolling back to previous revision..."
  kubectl rollout undo deployment/"$DEP" -n "$NS"
else
  echo "Rolling back to revision $REV..."
  kubectl rollout undo deployment/"$DEP" -n "$NS" --to-revision="$REV"
fi

echo
kubectl rollout status deployment/"$DEP" -n "$NS" --timeout=5m
echo
kubectl get pods -n "$NS" -l app="$DEP" -o wide
