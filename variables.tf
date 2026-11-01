
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  type = string
}

variable "humber_id" {
  description = "Last four digits of Humber ID"
  type        = string
}

variable "student_name" {
  description = "Student name for tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Learning"
}

variable "allowed_admin_ip" {
  description = "Trusted public IPv4 address in CIDR format"
  type        = string
}

variable "common_storage_account_name" {
  description = "Unique storage account name for common services"
  type        = string
}

variable "log_retention_days" {
  description = "Log Analytics retention period"
  type        = number
  default     = 30
}

variable "linux_vm_size" {
  type = string
}

variable "linux_admin_username" {
  type    = string
  default = "azureuser"
}

variable "linux_ssh_public_key_path" {
  type = string
}

variable "linux_ssh_private_key_path" {
  type = string
}

variable "linux_dns_prefix" {
  type = string
}

variable "windows_vm_size" {
  type = string
}

variable "windows_admin_username" {
  type    = string
  default = "azureadmin"
}

variable "windows_admin_password" {
  type      = string
  sensitive = true
}

