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
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
}
variable "storage_account_name" {
  type    = string
  default = ""
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}

