# Citadel Platform

Unified monorepo for Application, Infrastructure, Automation, and Artificial Intelligence work.

## Top-Level Structure

```
citadel-platform/
├── Application/                 # Runnable services, APIs, dashboards, business apps
├── Infrastructure/              # Declarative IaC + platform foundations (AWS, Azure, GCP, Kubernetes)
├── Automation/                  # Imperative scripts, ops tooling, CI helpers, audits
└── Artificial-Intelligence/     # AI platforms, agents, RAG, guardrails, knowledge bases
```

## Purpose

This repository consolidates previously scattered work from multiple repositories into a clear, discoverable layout:

- **Application** — code that runs as services or tools
- **Infrastructure** — how platforms and environments are defined (Terraform/HCL, manifests, landing zones)
- **Automation** — how we operate, audit, patch, and orchestrate (Bash, PowerShell, Python scripts)
- **Artificial-Intelligence** — Azure AI Foundry, OpenAI, Bedrock agents/guardrails/KB, RAG, etc.

## Getting Started

Browse the four top-level directories. Each contains a README describing its scope and current contents.

## Migration Status

- [x] Skeleton created
- [ ] Automation_Scripts content migrated under `Automation/`
- [ ] Selected AI / AKS private repos structured under their domains
- [ ] Additional content from AWS_Infra, Azure_Infra, Kubernetes_Enviro, Python_apps, etc.

## Conventions

- Prefer language or cloud sub-folders under each top-level domain.
- One focused concern per script/module.
- Destructive operations require explicit opt-in flags.
- Keep READMEs current at every significant folder level.
