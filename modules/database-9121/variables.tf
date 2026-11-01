
variable "humber_id" {
  description = "Last four digits of Humber ID"
  type        = string
}

variable "resource_group_name" {
  description = "Existing Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for PostgreSQL"
  type        = string
}

variable "administrator_login" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "pgadmin9121"
}

variable "administrator_password" {
  description = "PostgreSQL administrator password"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "PostgreSQL compute SKU"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "tags" {
  description = "Project resource tags"
  type        = map(string)
}

