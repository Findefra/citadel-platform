# Infrastructure

Declarative infrastructure-as-code and platform foundations.

## Intended Layout

```
Infrastructure/
├── aws/
│   ├── network-hub/
│   ├── eks/
│   ├── three-tier-web/
│   └── secure-static-site/
├── azure/
│   └── aks/                  # landing-zone, multi-env, gitops-platform
├── gcp/
└── kubernetes/             # manifests, patterns, kustomize, HPA, PDB, etc.
```

Content from the various `*-eks-*`, `azure-aks-*`, `AWS_Infra`, `Azure_Infra`, `GCP_Infra`, and `Kubernetes_Enviro` repositories belongs here.
