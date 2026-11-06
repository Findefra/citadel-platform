# Production Rollback Scripts

Battle-tested bash scripts for the most common production rollback scenarios a DevOps / Cloud Operations engineer faces.

## Structure

```
Automation/ops/rollback/
├── 01-k8s-deployment.sh
├── 02-asg-launch-template.sh
├── 03-terraform-state.sh
├── 04-db-migration.sh
├── 05-alb-traffic-shift.sh
├── 06-ec2-ami.sh
├── 07-config-file.sh
├── 08-helm-release.sh
├── 09-docker-compose.sh
├── 10-package-version.sh
├── 11-route53-dns.sh
├── 12-feature-flag.sh
├── 13-systemd-unit.sh
├── 14-ecs-service.sh
├── 15-orchestrated-rollback.sh
└── README.md
```

## Safety Principles

- Always prefer **dry-run** first
- Require explicit confirmation for destructive actions
- Backup before overwrite
- Log everything
- Tag resources for audit trail
- Prefer reversible operations

## Usage Notes

Most scripts expect AWS CLI / kubectl / helm already authenticated and configured for the target environment.

Adapt paths, ARNs, and cluster contexts to your environment before running in production.
