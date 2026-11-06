#!/usr/bin/env bash
# 05-alb-traffic-shift.sh
# Instantly shift 100% traffic back to the Blue target group
# Usage: ./05-alb-traffic-shift.sh <listener-arn> <blue-tg-arn> <green-tg-arn>

set -euo pipefail

LISTENER_ARN=${1:?Listener ARN required}
BLUE_TG_ARN=${2:?Blue Target Group ARN required}
GREEN_TG_ARN=${3:?Green Target Group ARN required}

echo "=== ALB Traffic Shift Rollback (100% Blue) ==="
echo "Listener : $LISTENER_ARN"
echo "Blue TG  : $BLUE_TG_ARN"
echo "Green TG : $GREEN_TG_ARN"
echo

aws elbv2 modify-listener \
  --listener-arn "$LISTENER_ARN" \
  --default-actions Type=forward,ForwardConfig="{
    TargetGroups=[
      {TargetGroupArn=$BLUE_TG_ARN,Weight=100},
      {TargetGroupArn=$GREEN_TG_ARN,Weight=0}
    ]
  }"

echo "Traffic shifted 100% → Blue"
