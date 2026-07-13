variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "aks-demo-rg"
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

variable "max_count" {
    description = "Max number of nodes to scale to"
    type = number
    default = 5
}

variable "vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "standard_b2als_v2"
}
