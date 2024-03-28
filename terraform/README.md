For local testing create a `local.auto.tfvars` in this directory with the following contents, to be able to use the [Terraform Azure Provider](https://registry.terraform.io/providers/tfproviders/azurerm/latest/docs):

```tf
azurerm_subscription_id = "<GUID>"
azurerm_tenant_id       = "<GUID>"
azurerm_client_id       = "<GUID>"
storage_account_name    = "<String>"
```

Any other variables can also be set or overriden in this file.

Also create a `providers.local_override.tf` in this directory with the following contents, to be able to use an [Azure Storage Account as backend](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm):

```tf
terraform {
  backend "azurerm" {
    subscription_id      = "<GUID>"
    tenant_id            = "<GUID>"
    client_id            = "<GUID>"
    resource_group_name  = "<String>"
    storage_account_name = "<String>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```


In both files replace the `<HIGHLIGTED_VALUES>` with the corresponding configuration of the environment.
