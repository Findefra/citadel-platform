# AWS CI/CD & Image Builder

Build hardened Windows/RHEL AMIs with EC2 Image Builder, then launch CI/CD agents or ML instances from them.

Key items from original repo:

- create-rhel-imagebuilder-pipeline.sh / create-windows-imagebuilder-pipeline.sh
- imagebuilder-pipelines.tf + apply-imagebuilder-tf.sh
- create-svb-base-image-pipelines.sh
- launch-rhel-ec2.sh / launch-windows-ec2.sh
- cicd-ml-orchestrator*.sh
- svb-120day-image-lifecycle.sh
- components/ (hardening + vuln-scan YAML)

Full content migration pending.
