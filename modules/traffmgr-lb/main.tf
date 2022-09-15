resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}


resource "azurerm_traffic_manager_profile" "profile" {
  name                   = var.profileName
  resource_group_name    = var.rgName
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_public_ip" "eastvnetip" {
  name                = "PublicIPForEastLB"
  location            = var.rglocation
  resource_group_name = var.rgName
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "eastvnetlb" {
  name                = "team4eastLB"
  location            = var.rglocation
  resource_group_name = var.rgName
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "FEIP"
    public_ip_address_id = azurerm_public_ip.eastvnetip.id
  }
}
resource "azurerm_public_ip" "centralvnetip" {
  name                = "team4centralLB"
  location            = var.rglocation2
  resource_group_name = var.rgName2
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "centralvnetlb" {
  name                = "team4centrallb"
  location            = var.rglocation2
  resource_group_name = var.rgName2
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.centralvnetip.id
  }
}



resource "azurerm_public_ip" "bastioneast" {
  name                = "BastionEastPIP"
  location            = var.rglocation
  resource_group_name = var.rgName
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastionhosteast" {
  name                = "BastionHostEast"
  location            = var.rglocation
  resource_group_name = var.rgName

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.BastionEastSub
    public_ip_address_id = azurerm_public_ip.bastioneast.id
  }
}

resource "azurerm_public_ip" "bastioncentral" {
  name                = "BastionCentralIP"
  location            = var.rglocation2
  resource_group_name = var.rgName2
  allocation_method   = "Static"
  sku = "Standard"
  
}

resource "azurerm_bastion_host" "bastionhostcentral" {
  name                = "BastionHostCentral"
  location            = var.rglocation2
  resource_group_name = var.rgName2

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.BastionCentralSub
    public_ip_address_id = azurerm_public_ip.bastioncentral.id
  }
}