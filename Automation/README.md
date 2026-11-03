# Automation

Imperative scripts, operational tooling, audits, CI helpers, and rollout automation.

## Current / Target Layout

```
Automation/
├── aws/
│   ├── audits/               # quarterly inventory & compliance (read-only)
│   ├── cicd/                 # EC2 Image Builder, launchers, TF helpers
│   ├── ops/                  # cleanup, backup, migration
│   └── rollout/              # ASG in-place patching, etc.
├── azure/                    # pipeline management, policy, cost, NSG, AKS ops
├── powershell/               # Windows / Visionline / server maintenance
├── python/                   # standalone Python utilities
├── redhat/                   # RHEL 9/10 tooling installers + reports
├── k8s/                      # Kubernetes ops scripts
└── ubuntu-app-host-ops/
```

Primary source: content from the `Automation_Scripts` repository is being migrated here.
