
output "linux_disk_names" {
  description = "Names of Linux data disks"

  value = {
    for key, disk in azurerm_managed_disk.linux :
    key => disk.name
  }
}

output "linux_disk_ids" {
  description = "IDs of Linux data disks"

  value = {
    for key, disk in azurerm_managed_disk.linux :
    key => disk.id
  }
}

output "windows_disk_name" {
  description = "Windows data disk name"
  value       = azurerm_managed_disk.windows.name
}

output "windows_disk_id" {
  description = "Windows data disk ID"
  value       = azurerm_managed_disk.windows.id
}

output "total_disks" {
  description = "Total managed data disks"
  value       = length(azurerm_managed_disk.linux) + 1
}

