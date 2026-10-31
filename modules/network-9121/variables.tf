
variable "resource_group_name" {
  description = "Existing resource group name"
  type        = string
}

variable "location" {
  description = "Azure deployment region"
  type        = string
}

variable "humber_id" {
  description = "Last four digits of Humber ID"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "allowed_ssh_source" {
  description = "Trusted public IP CIDR for SSH"
  type        = string
}

variable "allowed_rdp_source" {
  description = "Trusted public IP CIDR for RDP"
  type        = string
}

variable "allowed_winrm_source" {
  description = "Trusted public IP CIDR for WinRM"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}

