
locals {
  linux_vms = {
    vm1 = { zone = "1", number = "1" }
    vm2 = { zone = "2", number = "2" }
    vm3 = { zone = "3", number = "3" }
  }
}

# Public IP for each VM
resource "azurerm_public_ip" "linux_pip" {
  for_each = {
    for key, vm in local.linux_vms : key => vm
    if key != "vm3"
  }
  name                = "${var.humber_id}-linux-pip-${each.value.number}"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
  zones             = [each.value.zone]

  domain_name_label = "${var.dns_prefix}-linux-${each.value.number}"

  tags = var.tags
}

# Network interface for each VM
resource "azurerm_network_interface" "linux_nic" {
  for_each = local.linux_vms

  name                = "${var.humber_id}-linux-nic-${each.value.number}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = try(
      azurerm_public_ip.linux_pip[each.key].id,
      null
    )
  }

  tags = var.tags
}

# CentOS 8.2 virtual machines
resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = local.linux_vms

  name                = "${var.humber_id}-linux-vm-${each.value.number}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  zone = tostring(each.value.number)

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_uri
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Network Watcher extension
resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = local.linux_vms

  name               = "NetworkWatcherAgentLinux"
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[each.key].id

  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  auto_upgrade_minor_version = true

  tags = var.tags
}

# Azure Monitor Agent extension
resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = local.linux_vms

  name               = "AzureMonitorLinuxAgent"
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[each.key].id

  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"

  auto_upgrade_minor_version = true

  settings = jsonencode({
    authentication = {
      managedIdentity = {}
    }
  })

  tags = var.tags
}

