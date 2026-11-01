
# Three Linux Managed Data Disks
resource "azurerm_managed_disk" "linux" {
  for_each = var.linux_vm_ids

  name                 = "${var.humber_id}-linux-disk-${trimprefix(each.key, "vm")}"
  location             = var.linux_vm_locations[each.key]
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10

  zone = var.linux_vm_zones[each.key]

  tags = var.tags
}

# Attach One Disk to Each Linux VM
resource "azurerm_virtual_machine_data_disk_attachment" "linux" {
  for_each = var.linux_vm_ids

  managed_disk_id    = azurerm_managed_disk.linux[each.key].id
  virtual_machine_id = each.value

  lun     = 0
  caching = "ReadWrite"
}

# Windows Managed Data Disk
resource "azurerm_managed_disk" "windows" {
  name                 = "${var.humber_id}-windows-disk-1"
  location             = var.windows_vm_location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10

  tags = var.tags
}

# Attach Disk to Windows VM
resource "azurerm_virtual_machine_data_disk_attachment" "windows" {
  managed_disk_id    = azurerm_managed_disk.windows.id
  virtual_machine_id = var.windows_vm_id

  lun     = 0
  caching = "ReadWrite"
}

