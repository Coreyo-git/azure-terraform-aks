# Azure Terraform

Learning project for provisioning Azure infrastructure with Terraform, plus a Go web server that will authenticate with Entra ID.

## Layout

```
.
├── infra/                       # Terraform root module (run terraform from here)
│   ├── main.tf                  # Wires up the modules below
│   ├── providers.tf             # Terraform + azurerm provider config
│   └── modules/
│       ├── aks/                 # AKS cluster (work in progress)
│       └── governance/policies/ # Azure Policy: restrict resources to Australian regions
├── apps/
│   └── auth-server/             # Go web server (Entra ID auth planned)
│       ├── cmd/server/          # main package
│       └── go.mod
└── deploy/
    └── auth-server/             # Kubernetes manifests (Kustomize)
        ├── base/
        └── overlays/{dev,prod}/
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.15.0
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli): run `az login` before applying, and check the active subscription with `az account show`
- [kubectl](https://kubernetes.io/docs/tasks/tools/) to interact with the cluster
- [Go](https://go.dev/dl/) >= 1.26 for the web server

## Infrastructure

All Terraform commands run from `infra/`:

```bash
cd infra
terraform init
terraform plan
terraform apply
```

To tear everything down:

```bash
terraform destroy
```

After a destroy, check the portal for leftover `MC_*` or `NetworkWatcherRG` resource groups.

### Governance policies

`modules/governance/policies` assigns a subscription-level policy set that denies resources and resource groups outside the allowed locations (`australiaeast` and `australiasoutheast` by default). Change the effect with `default_policy_effect` (`Audit`, `Deny` or `Disabled`).

### AKS

The `modules/aks` module is a placeholder while the cluster config is moved into a module. Once it is in place, deploy the [AKS Store Demo](https://github.com/Azure-Samples/aks-store-demo) for hands-on practice:

```bash
kubectl create namespace pets
kubectl apply -f https://raw.githubusercontent.com/Azure-Samples/aks-store-demo/main/aks-store-all-in-one.yaml -n pets
```

## Go web server

```bash
cd apps/auth-server
go run ./cmd/server
```

Kubernetes manifests live in `deploy/auth-server`. Preview what an overlay renders with `kubectl kustomize deploy/auth-server/overlays/dev`, and apply it with `kubectl apply -k deploy/auth-server/overlays/dev`.

### Planned: Entra ID auth

1. Create an app registration in Entra ID (portal first, then Terraform with the `azuread` provider).
2. Add login to the Go server with OIDC (`coreos/go-oidc` + `golang.org/x/oauth2`) or MSAL Go.
3. Load the client ID, tenant ID and secret from environment variables (`.env`, ).
4. Deploy to AKS and replace the client secret with Workload Identity.

## Resources

- [Terraform azurerm provider docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AKS quickstart](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli)
- [Kubernetes basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
- [A Tour of Go](https://go.dev/tour)
- [Microsoft identity platform docs](https://learn.microsoft.com/en-us/entra/identity-platform/)
