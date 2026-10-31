
variable "resource_group_name" {
  description = "Existing Azure resource group name"
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

variable "storage_account_name" {
  description = "Globally unique storage account name"
  type        = string
}

variable "storage_replication_type" {
  description = "Storage redundancy"
  type        = string
  default     = "LRS"
}

variable "log_analytics_sku" {
  description = "Log Analytics workspace SKU"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Log Analytics retention in days"
  type        = number
  default     = 30
}

variable "recovery_vault_sku" {
  description = "Recovery Services vault SKU"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}

