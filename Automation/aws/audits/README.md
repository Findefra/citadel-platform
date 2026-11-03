# AWS Audits (Read-Only)

Quarterly review scripts that inventory and flag issues. They report; they do not modify or delete resources.

Most write a timestamped CSV report to a `quarterly-reports/` style output location.

Scripts (from original Automation_Scripts):

- cert-expiry-sweep.sh
- cicd-iam-role-audit.sh
- cloudwatch-tail-logs.sh
- codebuild-config-audit.sh
- codepipeline-health.sh
- ec2-inventory.sh
- ec2-stopped-orphans.sh
- ecr-image-age.sh
- ecr-repo-compliance.sh
- iam-key-age-audit.sh
- iam-key-rotation-audit.sh
- iam-user-group-audit.sh
- lambda-runtime-deprecation.sh
- lambda-unused-functions.sh
- org-account-inventory.sh
- public-exposure-check.sh
- quarterly-unused-resources.sh
- rds-config-audit.sh
- rds-snapshot-age.sh
- ri-sp-coverage.sh
- rightsizing-candidates.sh
- s3-bucket-health.sh
- s3-multipart-cleanup.sh
- scp-surface-review.sh
- security-group-review.sh
- sso-assignment-hygiene.sh
- sso-permission-set-audit.sh
- tag-compliance.sh

Full content will be copied from `Findefra/Automation_Scripts/aws/audits/` in subsequent migration commits.
