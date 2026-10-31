
output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "resource_group_id" {
  value = module.rgroup.resource_group_id
}

output "resource_group_location" {
  value = module.rgroup.resource_group_location
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "nsg_name" {
  value = module.network.nsg_name
}

output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name
}

output "log_analytics_workspace_id" {
  value = module.common.log_analytics_workspace_id
}

output "recovery_services_vault_name" {
  value = module.common.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "storage_account_id" {
  value = module.common.storage_account_id
}

output "storage_account_primary_blob_endpoint" {
  value = module.common.storage_account_primary_blob_endpoint
}

