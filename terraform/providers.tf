terraform {
  required_version = "~>1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.83.0"
    }
  }
  backend "azurerm" {
    container_name = "tfstate"
    key            = "terraform.tfstate"
    use_oidc       = true
  }
}

provider "azurerm" {
  features {}

  use_oidc        = true
  subscription_id = var.azurerm_subscription_id
  tenant_id       = var.azurerm_tenant_id
  client_id       = var.azurerm_client_id
}
variable "azurerm_subscription_id" {
  type = string
}
variable "azurerm_tenant_id" {
  type = string
}
variable "azurerm_client_id" {
  type = string
}
