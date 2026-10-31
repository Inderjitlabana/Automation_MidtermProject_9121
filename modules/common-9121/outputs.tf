
output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.law.id
}

output "log_analytics_workspace_resource_id" {
  description = "Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law.id
}

output "recovery_services_vault_name" {
  description = "Recovery Services vault name"
  value       = azurerm_recovery_services_vault.rsv.name
}

output "recovery_services_vault_id" {
  description = "Recovery Services vault ID"
  value       = azurerm_recovery_services_vault.rsv.id
}

output "storage_account_name" {
  description = "Common services storage account name"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  description = "Storage account resource ID"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_primary_blob_endpoint" {
  description = "Blob endpoint for VM boot diagnostics"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

