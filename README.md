# AspNetCore.Examples.TerraformAzure

This project serves as an example of how to deploy an ASP.Net Core application to Azure via Terraform with GitHub Actions.

The following deployment configurations are used:
  - Deploy an ASP.Net Core app to an Azure Web App running linux.
  - Deploy a contianerized ASP.Net Core app to an Azure Web App for Containers.

It makes use of the following technologies and projects:

- [.NET 8.0](https://dotnet.microsoft.com/download/dotnet/8.0)
- [ASP.NET Core 8.0](https://learn.microsoft.com/aspnet/core/?view=aspnetcore-8.0)
- [Docker](https://www.docker.com/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Terraform 1.7.5](https://www.terraform.io/)
- [Azure Terraform Provider 3.83.0](https://registry.terraform.io/providers/hashicorp/azurerm/3.83.0/docs)
- [Azure Terraform Backend](https://developer.hashicorp.com/terraform/language/v1.7.x/settings/backends/azurerm)
- [Azure Blob Storage](https://learn.microsoft.com/azure/storage/blobs/)
- [Azure Container Registry](https://learn.microsoft.com/azure/container-registry/)
- [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/)