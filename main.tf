resource "azurerm_resource_group" "main" {
    name = var.rgName
    location = var.rglocation
}
resource "azurerm_resource_group" "secondary"{
    name = var.rgName2
    location = var.rglocation2
 
}
 
resource "azurerm_storage_account" "storage" {
  name                     = var.storageName
  resource_group_name      = var.rgName
  location                 = azurerm_resource_group.main.location
  account_tier             = var.accounttier
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "container" {
  name                  = var.storageName
  storage_account_name  = azurerm_storage_account.storage.name
}
resource "azurerm_storage_blob" "storage" {
  name                   = var.blobName
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
}

module "network-scalesets" {
    source = "./modules/network-scalesets"

default_tags = var.default_tags
VNET_name1 = var.VNET_name1
VNET_name2 = var.VNET_name2
addySpace = var.addySpace
addySpace2 = var.addySpace2
addyPrefixVnet1 = var.addyPrefixVnet1
addyPrefixVnet2 = var.addyPrefixVnet2
vnet1sub = var.vnet1sub
vnet2sub = var.vnet2sub
rgName = var.rgName
rgName2 = var.rgName2
rglocation = var.rglocation
rglocation2 = var.rglocation2
storageName = var.storageName
}