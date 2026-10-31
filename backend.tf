
terraform {
  backend "azurerm" {
    resource_group_name  = "9121-tfstate-rg"
    storage_account_name = "tfstate75b05d28349e"
    container_name       = "tfstate"
    key                  = "project-9121.tfstate"

    use_cli          = true
    use_azuread_auth = true
  }
}

