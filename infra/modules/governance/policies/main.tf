data "azurerm_subscription" "current" {}

data "azurerm_policy_definition_built_in" "allowed_locations" {
  display_name = "Allowed locations"
}

data "azurerm_policy_definition_built_in" "allowed_locations_rg" {
  display_name = "Allowed locations for resource groups"
}

resource "azurerm_policy_set_definition" "au_locations_only" {
  name         = "au_locations_only"
  policy_type  = "Custom"
  display_name = "Only allow Australian location for resources"

  parameters = jsonencode({
    listOfAllowedLocations = {
      type = "Array"
      metadata = {
        display_name = "Allowed locations"
        strongType   = "location"
      }
      default = [var.default_resource_location]
    }
    policyEffects = {
      type = "String"
      metadata = {
        display_name = "Allowed effects"
      }
      allowedValues = var.allowed_effects
      default       = var.default_policy_effect
    }
  })

  policy_definition_reference {
    reference_id         = "resources"
    policy_definition_id = data.azurerm_policy_definition_built_in.allowed_locations.id
    parameter_values = jsonencode({
      listOfAllowedLocations = {
        value = "[parameters('listOfAllowedLocations')]"
      },
      effect = {
        value = "[parameters('policyEffects')]"
      }
    })
  }

  policy_definition_reference {
    reference_id         = "resource_groups"
    policy_definition_id = data.azurerm_policy_definition_built_in.allowed_locations_rg.id
    parameter_values = jsonencode({
      listOfAllowedLocations = {
        value = "[parameters('listOfAllowedLocations')]"
      },
      effect = {
        value = "[parameters('policyEffects')]"
      }
    })
  }
}

resource "azurerm_subscription_policy_assignment" "au_locations_only" {
  name                 = "au_locations_only"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_set_definition.au_locations_only.id
  display_name         = "Deny resources outside Australia"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_resource_locations_list
    },
    policyEffects = {
      value = var.default_policy_effect
    }
  })

  non_compliance_message {
    content = "Only create resources and resource groups in the allowed locations: ${join(", ", var.allowed_resource_locations_list)}."
  }
}
