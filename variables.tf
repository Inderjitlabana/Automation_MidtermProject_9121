
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
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

