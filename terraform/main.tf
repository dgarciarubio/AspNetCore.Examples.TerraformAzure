resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
variable "resource_group_name" {
  type    = string
  default = "AspNetCore.Examples.TerraformAzure"
}
variable "resource_group_location" {
  type    = string
  default = "westeurope"
}

resource "azurerm_storage_account" "st" {
  name                             = var.storage_account_name
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  account_tier                     = var.storage_account_tier
  account_replication_type         = var.storage_account_replication_type
  access_tier                      = var.storage_account_access_tier
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  lifecycle {
    prevent_destroy = true
  }
}
variable "storage_account_name" {
  type = string
}
variable "storage_account_tier" {
  type    = string
  default = "Standard"
}
variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}
variable "storage_account_access_tier" {
  type    = string
  default = "Hot"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.container_registry_sku
  admin_enabled       = true
}
variable "container_registry_name" {
  type = string
}
variable "container_registry_sku" {
  type    = string
  default = "Basic"
}

resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
}
variable "service_plan_name" {
  type    = string
  default = "AspNetCoreExamplesTerraformAzure"
}
variable "service_plan_sku" {
  type    = string
  default = "F1"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.linux_web_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.sp.id
  https_only          = true

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
variable "linux_web_app_name" {
  type    = string
  default = "aspnetcore-examples-terraformazure-linuxwebapp"
}

resource "azurerm_linux_web_app" "docker_app" {
  name                = var.docker_web_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.sp.id
  https_only          = true

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL          = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME     = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = azurerm_container_registry.acr.admin_password
  }

  site_config {
    always_on = false
  }
}
variable "docker_web_app_name" {
  type    = string
  default = "aspnetcore-examples-terraformazure-dockerwebapp"
}
