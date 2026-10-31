
locals {
  common_tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = var.student_name
    ExpirationDate = "2027-12-31"
    Environment    = var.environment
  }

  resource_group_name = "${var.humber_id}-RG"
}


module "rgroup" {
  source = "./modules/rgroup-9121"

  resource_group_name = local.resource_group_name
  location            = var.location
  tags                = local.common_tags
}


module "network" {
  source = "./modules/network-9121"

  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  humber_id           = var.humber_id

  vnet_address_space      = ["10.0.0.0/16"]
  subnet_address_prefixes = ["10.0.1.0/24"]

  allowed_ssh_source   = var.allowed_admin_ip
  allowed_rdp_source   = var.allowed_admin_ip
  allowed_winrm_source = var.allowed_admin_ip

  tags = local.common_tags
}


module "common" {
  source = "./modules/common-9121"

  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  humber_id           = var.humber_id

  storage_account_name     = var.common_storage_account_name
  storage_replication_type = "LRS"

  log_analytics_sku  = "PerGB2018"
  log_retention_days = var.log_retention_days

  recovery_vault_sku = "Standard"

  tags = local.common_tags
}

