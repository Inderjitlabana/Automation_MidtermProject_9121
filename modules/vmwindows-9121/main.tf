
# Windows Availability Set
resource "azurerm_availability_set" "windows" {
  name                         = "${var.humber_id}-windows-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

# Public IP
resource "azurerm_public_ip" "windows" {
  count = var.vm_count

  name                = "${var.humber_id}-windows-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label = "win-${var.humber_id}-${count.index + 1}"

  tags = var.tags
}

# Network Interface
resource "azurerm_network_interface" "windows" {
  count = var.vm_count

  name                = "${var.humber_id}-windows-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows[count.index].id
  }

  tags = var.tags
}

# Windows Server 2022 VM
resource "azurerm_windows_virtual_machine" "windows" {
  count = var.vm_count

  name          = "${var.humber_id}-windows-vm-${count.index + 1}"
  computer_name = "win${var.humber_id}${count.index + 1}"

  location            = var.location
  resource_group_name = var.resource_group_name

  size           = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password

  availability_set_id = azurerm_availability_set.windows.id

  network_interface_ids = [
    azurerm_network_interface.windows[count.index].id
  ]

  os_disk {
    name                 = "${var.humber_id}-windows-osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_blob_endpoint
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Microsoft Antimalware
resource "azurerm_virtual_machine_extension" "antimalware" {
  count = var.vm_count

  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    AntimalwareEnabled        = true
    RealtimeProtectionEnabled = true
    ScheduledScanSettings = {
      isEnabled = false
    }
  })

  tags = var.tags
}

# Optional Azure Monitor Agent
resource "azurerm_virtual_machine_extension" "monitor" {
  count = var.enable_monitor_agent ? var.vm_count : 0

  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows[count.index].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.22"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    authentication = {
      managedIdentity = {}
    }
  })

  tags = var.tags
}

