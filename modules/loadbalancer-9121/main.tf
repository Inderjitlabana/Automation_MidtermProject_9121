
# 1. Public IP for the Load Balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.humber_id}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label = "ccgc-lb-${var.humber_id}"

  tags = var.tags
}

# 2. Standard Load Balancer
resource "azurerm_lb" "main" {
  name                = "${var.humber_id}-LB"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }

  tags = var.tags
}

# 3. Backend Address Pool
resource "azurerm_lb_backend_address_pool" "linux" {
  name            = "${var.humber_id}-linux-backend"
  loadbalancer_id = azurerm_lb.main.id
}

# 4. Associate All Three Linux NICs
resource "azurerm_network_interface_backend_address_pool_association" "linux" {
  for_each = var.linux_nic_ids

  network_interface_id    = each.value
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.linux.id
}

# 5. Health Probe
resource "azurerm_lb_probe" "http" {
  name            = "${var.humber_id}-http-probe"
  loadbalancer_id = azurerm_lb.main.id

  protocol = "Tcp"
  port     = 80
}

# 6. HTTP Load Balancing Rule
resource "azurerm_lb_rule" "http" {
  name            = "${var.humber_id}-http-rule"
  loadbalancer_id = azurerm_lb.main.id

  protocol      = "Tcp"
  frontend_port = 80
  backend_port  = 80

  frontend_ip_configuration_name = "PublicFrontend"
  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.linux.id
  ]

  probe_id = azurerm_lb_probe.http.id

  disable_outbound_snat = true
}

