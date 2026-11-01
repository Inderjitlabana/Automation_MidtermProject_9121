
output "windows_hostnames" {
  value = azurerm_windows_virtual_machine.windows[*].computer_name
}

output "windows_vm_names" {
  value = azurerm_windows_virtual_machine.windows[*].name
}

output "windows_fqdns" {
  value = azurerm_public_ip.windows[*].fqdn
}

output "windows_private_ips" {
  value = azurerm_network_interface.windows[*].private_ip_address
}

output "windows_public_ips" {
  value = azurerm_public_ip.windows[*].ip_address
}

output "windows_vm_ids" {
  value = azurerm_windows_virtual_machine.windows[*].id
}

output "windows_availability_set_name" {
  value = azurerm_availability_set.windows.name
}

