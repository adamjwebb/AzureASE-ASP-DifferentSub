variable "appServiceEnvironmentId" {
  type        = string
}

variable "appServicePlanResourceGroupName" {
  type        = string
}

variable "namingPrefix" {
  type        = string
}

provider "azurerm" {
  features {}
   }

data "azurerm_resource_group" "appServicePlanResourceGroup" {
  name = var.appServicePlanResourceGroupName
}

resource "azurerm_service_plan" "appServicePlan" {
  name                = "${var.namingPrefix}-asp"
  resource_group_name = data.azurerm_resource_group.appServicePlanResourceGroup.name
  location            = data.azurerm_resource_group.appServicePlanResourceGroup.location
  os_type             = "Linux"
  sku_name            = "I1v2"
  app_service_environment_id = var.appServiceEnvironmentId
}

resource "azurerm_linux_web_app" "appService" {
  name                  = "${var.namingPrefix}-app"
  location              = data.azurerm_resource_group.appServicePlanResourceGroup.location
  resource_group_name   = data.azurerm_resource_group.appServicePlanResourceGroup.name
  service_plan_id       = azurerm_service_plan.appServicePlan.id
  
  site_config {
  }
}