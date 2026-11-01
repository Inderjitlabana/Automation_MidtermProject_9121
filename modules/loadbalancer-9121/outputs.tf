
output "loadbalancer_name" {
  description = "Name of the Azure Load Balancer"
  value       = azurerm_lb.main.name
}

output "loadbalancer_public_ip" {
  description = "Public IP of the Load Balancer"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "loadbalancer_fqdn" {
  description = "DNS name of the Load Balancer"
  value       = azurerm_public_ip.lb_pip.fqdn
}

output "backend_pool_id" {
  description = "Linux backend pool ID"
  value       = azurerm_lb_backend_address_pool.linux.id
}

