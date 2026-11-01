
variable "humber_id" {
  description = "Last four digits of Humber ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group"
  type        = string
}

variable "linux_nic_ids" {
  description = "Map of the three existing Linux NIC IDs"
  type        = map(string)
}

variable "tags" {
  description = "Project resource tags"
  type        = map(string)
}

