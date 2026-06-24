# Azure AKS Terraform

Learning project for provisioning an AKS Kubernetes cluster on Azure using Terraform.

## What it does

- Creates an Azure Resource Group
- Provisions an AKS cluster with a 2-node default node pool
- Outputs the kubeconfig to connect with `kubectl`

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.1.0
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) — run `az login` before applying
- [kubectl](https://kubernetes.io/docs/tasks/tools/) — to interact with the cluster after provisioning

## Usage

```bash
terraform init
terraform plan
terraform apply
```

To connect to the cluster after apply:

```bash
terraform output -raw kube_config > ~/.kube/config
kubectl get nodes
```

To tear everything down:

```bash
terraform destroy
```

## Next steps

Eventually deploy the [AKS Store Demo](https://github.com/Azure-Samples/aks-store-demo) for hands-on practice with AKS, kubectl, and Kubernetes concepts:

```bash
kubectl create namespace pets
kubectl apply -f https://raw.githubusercontent.com/Azure-Samples/aks-store-demo/main/aks-store-all-in-one.yaml -n pets
```

## Resources

- [Terraform azurerm provider docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AKS quickstart](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli)
- [Kubernetes basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
