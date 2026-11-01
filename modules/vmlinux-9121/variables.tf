
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "humber_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "boot_diagnostics_storage_uri" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1ms"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}

