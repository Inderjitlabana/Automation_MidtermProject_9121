
output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "resource_group_id" {
  value = module.rgroup.resource_group_id
}

output "resource_group_location" {
  value = module.rgroup.resource_group_location
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "nsg_name" {
  value = module.network.nsg_name
}

