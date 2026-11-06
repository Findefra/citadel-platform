#!/usr/bin/env bash
# 15-orchestrated-rollback.sh
# High-level runbook that coordinates multiple rollback steps in the correct order
# Customize the called scripts and parameters for your environment

set -euo pipefail

echo "=== Orchestrated Production Rollback ==="
echo "Started at: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo

# 1. Shift traffic away from the bad version first (fastest safety)
echo "[1/4] Shifting traffic..."
# ./05-alb-traffic-shift.sh "$LISTENER_ARN" "$BLUE_TG_ARN" "$GREEN_TG_ARN"
echo "  (uncomment and fill ARNs)"
echo

# 2. Application / container rollback
echo "[2/4] Rolling back application..."
# ./01-k8s-deployment.sh "$NS" "$DEPLOYMENT"
# or ./08-helm-release.sh "$RELEASE" "$NS"
# or ./14-ecs-service.sh "$CLUSTER" "$SERVICE" "$PREV_TASK_DEF"
echo "  (uncomment the appropriate application rollback)"
echo

# 3. Database (only if schema change is involved and reversible)
echo "[3/4] Database migration rollback (if needed)..."
# ./04-db-migration.sh "$TARGET_VERSION" "$ENV"
echo "  (only if a migration needs to be reversed)"
echo

# 4. Verification
echo "[4/4] Verification steps:"
echo "  - Check application health endpoints"
echo "  - Check error rates / latency in monitoring"
echo "  - Confirm traffic is healthy on the rolled-back version"
echo

echo "Orchestrated rollback sequence finished."
echo "Monitor closely for the next 15–30 minutes."
echo "Finished at: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
