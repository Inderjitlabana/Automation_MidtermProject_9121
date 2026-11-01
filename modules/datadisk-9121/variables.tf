
variable "humber_id" {
  description = "Last four digits of Humber ID"
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group"
  type        = string
}

variable "linux_vm_ids" {
  description = "Map of Linux VM IDs"
  type        = map(string)
}

variable "linux_vm_locations" {
  description = "Map of Linux VM locations"
  type        = map(string)
}

variable "linux_vm_zones" {
  description = "Map of Linux VM availability zones"
  type        = map(string)
}

variable "windows_vm_id" {
  description = "Existing Windows VM ID"
  type        = string
}

variable "windows_vm_location" {
  description = "Windows VM location"
  type        = string
}

variable "tags" {
  description = "Project resource tags"
  type        = map(string)
}

