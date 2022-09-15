resource "azurerm_mysql_server" "east" {
  name                = "team4proj2s1"
  location            = var.rglocation
  resource_group_name = var.rgName

  administrator_login          = "adminuser"
  administrator_login_password = "Password123456"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
resource "azurerm_mysql_database" "east" {
  name                = "team4proj2eastDB"
  resource_group_name = azurerm_mysql_server.east.resource_group_name
  server_name         = azurerm_mysql_server.east.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_server" "central" {
  name                = "team4proj2s2"
  location            = var.rglocation2
  resource_group_name = var.rgName2

  administrator_login          = "adminuser"
  administrator_login_password = "Password123456"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
resource "azurerm_mysql_database" "central" {
  name                = "team4proj2centralDB"
  resource_group_name = azurerm_mysql_server.central.resource_group_name
  server_name         = azurerm_mysql_server.central.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
