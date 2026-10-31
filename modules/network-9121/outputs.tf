
output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.subnet.name
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.subnet.id
}

output "nsg_name" {
  description = "Network security group name"
  value       = azurerm_network_security_group.nsg.name
}

