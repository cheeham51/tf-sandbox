variable "env" {
  type        = string
  description = "Environment name"
}

variable "webhook_api_gateway_name_override" {
  type        = string
  description = "Override the api gateway name"
}

variable "webhook_domain_override" {
  type        = string
  description = "Override the domain name to use"
}

variable "webhook_log_group_override" {
  type        = string
  description = "Webhook log group override"
}

variable "cloudwatch_retention_period" {
  type        = number
  description = "Log retention time"
}