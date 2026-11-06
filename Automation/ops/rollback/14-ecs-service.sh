#!/usr/bin/env bash
# 14-ecs-service.sh
# Force ECS service to a previous task definition
# Usage: ./14-ecs-service.sh <cluster> <service> <task-definition>

set -euo pipefail

CLUSTER=${1:?Cluster name required}
SERVICE=${2:?Service name required}
TASK_DEF=${3:?Previous task definition ARN or family:revision required}

echo "=== ECS Service Rollback ==="
echo "Cluster      : $CLUSTER"
echo "Service      : $SERVICE"
echo "Task Def     : $TASK_DEF"
echo

aws ecs update-service \
  --cluster "$CLUSTER" \
  --service "$SERVICE" \
  --task-definition "$TASK_DEF" \
  --force-new-deployment

echo "Waiting for service to stabilize..."
aws ecs wait services-stable --cluster "$CLUSTER" --services "$SERVICE"

echo "Service is stable on $TASK_DEF"
