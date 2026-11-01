
output "linux_vm_names" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.linux_vm :
    k => vm.name
  }
}

output "linux_vm_ids" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm :
    key => vm.id
  }
}

output "linux_vm_locations" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm :
    key => vm.location
  }
}

output "linux_public_ips" {
  value = {
    for key, pip in azurerm_public_ip.linux_pip :
    key => pip.ip_address
  }
}

output "linux_fqdns" {
  value = {
    for key, pip in azurerm_public_ip.linux_pip :
    key => pip.fqdn
  }
}

output "linux_nic_ids" {
  value = {
    for k, nic in azurerm_network_interface.linux_nic :
    k => nic.id
  }
}

output "linux_zones" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm :
    key => vm.zone
  }
}
output "linux_vm_zones" {
  description = "Availability zones of the Linux VMs"

  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm :
    key => vm.zone
  }
}
