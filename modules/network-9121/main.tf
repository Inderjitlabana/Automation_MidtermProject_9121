
# 1. Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.humber_id}-VNET"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = var.tags
}

# 2. Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.humber_id}-SUBNET"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# 3. Create Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.humber_id}-NSG"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# 4. Create four inbound NSG rules
locals {
  inbound_rules = {
    ssh = {
      name     = "Allow-SSH"
      priority = 100
      port     = "22"
      source   = var.allowed_ssh_source
    }

    rdp = {
      name     = "Allow-RDP"
      priority = 110
      port     = "3389"
      source   = var.allowed_rdp_source
    }

    winrm = {
      name     = "Allow-WinRM"
      priority = 120
      port     = "5985"
      source   = var.allowed_winrm_source
    }

    http = {
      name     = "Allow-HTTP"
      priority = 130
      port     = "80"
      source   = "*"
    }
  }
}

resource "azurerm_network_security_rule" "inbound" {
  for_each = local.inbound_rules

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = each.value.port
  source_address_prefix      = each.value.source
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# 5. Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

