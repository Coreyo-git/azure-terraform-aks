variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "Pay-As-You-Go"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "my-aks-cluster"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_B2s"
}
