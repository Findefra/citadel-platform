# Citadel Platform

Unified monorepo for Application, Infrastructure, Automation, and Artificial Intelligence work.

**Repo:** https://github.com/Findefra/citadel-platform

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

## Current Progress

- [x] Skeleton created with four top-level domains + READMEs
- [x] `Automation/` folder structure populated (aws/audits, aws/cicd, aws/ops, powershell, python, redhat, ubuntu-app-host-ops) ready to receive content from `Automation_Scripts`
- [x] First private AI repo migrated: `azure-ai-foundry` → `Artificial-Intelligence/azure/foundry/` (partial; module bodies still being completed)
- [ ] Full file-by-file migration of `Automation_Scripts` scripts under `Automation/`
- [ ] Remaining AI / AKS / Infra private repos
- [ ] Content from `Python_apps`, `Kubernetes_Enviro`, `AWS_Infra`, `Azure_Infra`, etc.

## Conventions

- Prefer language or cloud sub-folders under each top-level domain.
- One focused concern per script/module.
- Destructive operations require explicit opt-in flags.
- Keep READMEs current at every significant folder level.

## Source Mapping (planned)

| Original repo                  | Target location                                      |
|--------------------------------|------------------------------------------------------|
| Automation_Scripts             | Automation/                                          |
| azure-ai-foundry               | Artificial-Intelligence/azure/foundry/               |
| azure-ai-search-rag            | Artificial-Intelligence/azure/ai-search-rag/         |
| azure-openai-enterprise        | Artificial-Intelligence/azure/openai-enterprise/     |
| bedrock-*                      | Artificial-Intelligence/aws/                         |
| azure-aks-* / aws-eks-*        | Infrastructure/azure/aks/ and Infrastructure/aws/eks/|
| Kubernetes_Enviro              | Infrastructure/kubernetes/                           |
| Python_apps                    | Application/python/ (+ some Automation/python)       |
