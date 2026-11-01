
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

module "vmlinux" {
  source = "./modules/vmlinux-9121"

  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  humber_id           = var.humber_id

  subnet_id = module.network.subnet_id

  boot_diagnostics_storage_uri = module.common.storage_account_primary_blob_endpoint

  vm_size        = var.linux_vm_size
  admin_username = var.linux_admin_username

  ssh_public_key_path  = var.linux_ssh_public_key_path
  ssh_private_key_path = var.linux_ssh_private_key_path

  dns_prefix = var.linux_dns_prefix

  tags = local.common_tags
}

module "vmwindows" {
  source = "./modules/vmwindows-9121"

  humber_id = var.humber_id
  location  = var.location

  resource_group_name = module.rgroup.resource_group_name
  subnet_id           = module.network.subnet_id

  storage_account_blob_endpoint = module.common.storage_account_primary_blob_endpoint

  vm_count = 1
  vm_size  = var.windows_vm_size

  admin_username = var.windows_admin_username
  admin_password = var.windows_admin_password

  enable_monitor_agent = true

  tags = local.tags
}

module "datadisk" {
  source = "./modules/datadisk-9121"

  humber_id           = var.humber_id
  resource_group_name = module.rgroup.resource_group_name

  linux_vm_ids       = module.vmlinux.linux_vm_ids
  linux_vm_locations = module.vmlinux.linux_vm_locations
  linux_vm_zones     = module.vmlinux.linux_vm_zones

  windows_vm_id       = module.vmwindows.windows_vm_ids[0]
  windows_vm_location = var.location

  tags = local.tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer-9121"

  humber_id           = var.humber_id
  location            = var.location
  resource_group_name = module.rgroup.resource_group_name

  linux_nic_ids = module.vmlinux.linux_nic_ids

  tags = local.tags
}

