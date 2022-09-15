#NETWORK
 
resource "azurerm_virtual_network" "vnet1" {
name = var.VNET_name1
location = var.rglocation
resource_group_name = var.rgName
tags = var.default_tags
address_space = var.addySpace
}
resource "azurerm_virtual_network" "vnet2" {
name = var.VNET_name2
location = var.rglocation2
resource_group_name = var.rgName2
tags = var.default_tags
address_space = var.addySpace2
}
 
resource "azurerm_subnet" "web_tier_east" {
name = var.vnet1sub
resource_group_name = var.rgName
virtual_network_name = var.VNET_name1
address_prefixes = var.addyPrefixVnet1
 
}
resource "azurerm_subnet" "bastion_host_east" {
name = "AzureBastionSubnet"
resource_group_name = var.rgName
virtual_network_name = azurerm_virtual_network.vnet1.name
address_prefixes = ["10.10.2.0/24"]
 
} 

resource "azurerm_subnet" "sql_server_east" {
name = "sql_server"
resource_group_name = var.rgName
virtual_network_name = var.VNET_name1
address_prefixes = ["10.10.3.0/24"]
 
}
resource "azurerm_subnet" "web_tier_central" {
name = var.vnet2sub
resource_group_name = var.rgName2
virtual_network_name = var.VNET_name2
address_prefixes = var.addyPrefixVnet2
 
}
 
resource "azurerm_subnet" "bastion_host_central" {
name = "AzureBastionSubnet"
resource_group_name = var.rgName2
virtual_network_name = var.VNET_name2
address_prefixes = ["10.11.2.0/24"]
 
}
 
 resource "azurerm_subnet" "sql_server_central" {
name = "sql_server"
resource_group_name = var.rgName2
virtual_network_name = var.VNET_name2
address_prefixes = ["10.11.3.0/24"]
 
}
 
resource "azurerm_virtual_network_peering" "peering1" {
  name                      = "vnet1-vnet2"
  resource_group_name       = var.rgName
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}
 
resource "azurerm_virtual_network_peering" "peering2" {
  name                      = "vnet2-vnet1"
  resource_group_name       = var.rgName2
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}
 
#SCALESETS
 
resource "azurerm_linux_virtual_machine_scale_set" "web_tier_east" {
  name                = "web-tier"
  resource_group_name = var.rgName
  location            = var.rglocation
  sku                 = "Standard_F2"
  instances           = 3
  admin_username      = "adminuser"
  admin_password = "Password123456"
  disable_password_authentication = false
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
 
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  # os_profile {
  #   computer_name  = "web-tier"
  #   admin_username = "adminuser"
  #   admin_password = "Password123456"
  #   custom_data = filebase64("prac.sh")
  # }
  network_interface {
    name    = "web_tier"
    primary = true
 
    ip_configuration {
      name      = "web_tier"
      primary   = true
      subnet_id = azurerm_subnet.web_tier_east.id
    }
  }
}
 
 
resource "azurerm_linux_virtual_machine_scale_set" "web_tier_central" {
  name                = "web-tier"
  resource_group_name = var.rgName2
  location            = var.rglocation2
  sku                 = "Standard_F2"
  instances           = 3
  admin_username      = "adminuser"
  admin_password = "Password123456"
  disable_password_authentication = false
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
 
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
#  os_profile {
#     computer_name  = "web-tier"
#     admin_username = "adminuser"
#     admin_password = "Password123456"
#     custom_data = filebase64("prac.sh")
#   }
  network_interface {
    name    = "web_tier"
    primary = true
 
    ip_configuration {
      name      = "web_tier"
      primary   = true
      subnet_id = azurerm_subnet.web_tier_central.id
    }
  }
}

