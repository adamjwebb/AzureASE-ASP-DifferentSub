locals {
  roleName = "Custom Role - Join App Service Plan to App Service Environment"
  actions = ["Microsoft.Web/hostingEnvironments/Join/Action"]
  notActions = []
}

data "azurerm_subscription" "scopeSubscription" {
}

resource "azurerm_role_definition" "roleDef" {
  name        = local.roleName
  scope       = data.azurerm_subscription.scopeSubscription.id

  permissions {
    actions     = local.actions
    not_actions = local.notActions
  }
}