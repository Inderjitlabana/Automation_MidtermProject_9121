
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

