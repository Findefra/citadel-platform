#!/usr/bin/env bash
# 06-ec2-ami.sh
# Launch a replacement instance from a previous AMI (manual DNS/TG update still required)
# Usage: ./06-ec2-ami.sh <instance-id> <previous-ami-id> <subnet-id> <sg-id> <key-name>

set -euo pipefail

INSTANCE_ID=${1:?Instance ID required}
PREVIOUS_AMI=${2:?Previous AMI ID required}
SUBNET_ID=${3:?Subnet ID required}
SG_ID=${4:?Security Group ID required}
KEY_NAME=${5:?Key pair name required}

echo "=== EC2 AMI Rollback ==="
echo "Original instance : $INSTANCE_ID"
echo "Target AMI        : $PREVIOUS_AMI"
echo

INSTANCE_TYPE=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].InstanceType' \
  --output text)

echo "Detected instance type: $INSTANCE_TYPE"

# Audit tag
aws ec2 create-tags --resources "$INSTANCE_ID" \
  --tags Key=Rollback,Value="$(date -u +%Y-%m-%dT%H:%M:%SZ)" Key=PreviousAMI,Value="$PREVIOUS_AMI"

NEW_ID=$(aws ec2 run-instances \
  --image-id "$PREVIOUS_AMI" \
  --instance-type "$INSTANCE_TYPE" \
  --subnet-id "$SUBNET_ID" \
  --security-group-ids "$SG_ID" \
  --key-name "$KEY_NAME" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=rollback-from-$INSTANCE_ID},{Key=Rollback,Value=true}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

echo
echo "New instance launched: $NEW_ID"
echo "Next steps:"
echo "  1. Wait for instance to become healthy"
echo "  2. Update DNS / Target Group / ASG as needed"
echo "  3. Terminate original instance $INSTANCE_ID only after verification"
