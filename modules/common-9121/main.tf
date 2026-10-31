
# 1. Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.humber_id}-law"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = var.log_analytics_sku
  retention_in_days = var.log_retention_days

  tags = var.tags
}

# 2. Create Recovery Services Vault
resource "azurerm_recovery_services_vault" "rsv" {
  name                = "rsv-${var.humber_id}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = var.recovery_vault_sku
  storage_mode_type = "LocallyRedundant"

  soft_delete_enabled = true

  tags = var.tags
}

# 3. Create Storage Account
resource "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  account_kind             = "StorageV2"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  tags = var.tags
}

