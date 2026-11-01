
variable "humber_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "storage_account_blob_endpoint" {
  type = string
}

variable "vm_count" {
  type    = number
  default = 1
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "enable_monitor_agent" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}

