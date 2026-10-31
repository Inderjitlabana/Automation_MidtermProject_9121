
output "resource_group_name" {
  description = "Created resource group name"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "Created resource group ID"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  description = "Resource group region"
  value       = azurerm_resource_group.rg.location
}

