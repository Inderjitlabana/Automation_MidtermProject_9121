
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = "${var.humber_id}-postgresql-ca-server"
  resource_group_name = var.resource_group_name
  location            = var.location

  version = "16"

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name   = var.sku_name
  storage_mb = 32768

  backup_retention_days = 7

  public_network_access_enabled = false

  tags = var.tags
}

