#!/usr/bin/env bash
# 02-asg-launch-template.sh
# Point an Auto Scaling Group back to a previous Launch Template version
# Usage: ./02-asg-launch-template.sh <asg-name> <lt-version>

set -euo pipefail

ASG_NAME=${1:?ASG name required}
LT_VERSION=${2:?Launch Template version required}

echo "=== ASG Launch Template Rollback ==="
echo "ASG          : $ASG_NAME"
echo "Target LT Ver: $LT_VERSION"
echo

CURRENT=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names "$ASG_NAME" \
  --query 'AutoScalingGroups[0].LaunchTemplate' \
  --output json)

echo "Current Launch Template:"
echo "$CURRENT" | jq .
echo

LT_ID=$(echo "$CURRENT" | jq -r .LaunchTemplateId)

echo "Updating ASG to LT version $LT_VERSION..."
aws autoscaling update-auto-scaling-group \
  --auto-scaling-group-name "$ASG_NAME" \
  --launch-template "LaunchTemplateId=$LT_ID,Version=$LT_VERSION"

echo
echo "ASG updated. New instances will launch with LT version $LT_VERSION."
echo "Optional next step (instance refresh):"
echo "  aws autoscaling start-instance-refresh --auto-scaling-group-name $ASG_NAME"
