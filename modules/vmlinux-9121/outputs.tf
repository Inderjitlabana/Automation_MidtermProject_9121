
output "linux_vm_names" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.linux_vm :
    k => vm.name
  }
}

output "linux_vm_ids" {
  value = {
    for k, vm in azurerm_linux_virtual_machine.linux_vm :
    k => vm.id
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
    for k, vm in azurerm_linux_virtual_machine.linux_vm :
    k => vm.zone
  }
}

