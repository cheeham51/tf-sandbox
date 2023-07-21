variable "is_admin_account" {
  description = "Indicates if this account is the Security Hub administrator account"
  type        = bool
  default     = false
}

variable "admin_account_id" {
  description = "The AWS account ID of the Security Hub administrator account"
  type        = string
  default     = ""
}