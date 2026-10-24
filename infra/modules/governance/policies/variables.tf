# --- Locations ---
variable "allowed_resource_locations_list" {
  description = "A list of allowed locations for azure resources and resource groups."
  type        = list(string)
  default     = ["australiaeast", "australiasoutheast", ]
}

variable "default_resource_location" {
  description = "The default location for resources and resource groups."
  type        = string
  default     = "australiaeast"
}

# --- Effects ---
variable "allowed_effects" {
  description = "A list of allowed policy effects"
  type        = list(string)
  default     = ["Audit", "Deny", "Disabled"]
}

variable "default_policy_effect" {
  description = "The default policy effect. (etc Audit, Deny, Disabled)."
  type        = string
  default     = "Deny"
}

