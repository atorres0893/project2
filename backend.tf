terraform {
  backend "azurerm" {
    resource_group_name = "Team4Proj2RG"
    storage_account_name = "team4proj2storage"
    container_name = "team4proj2storage"
    key = "prod.terraform.tfstate"
  }
}