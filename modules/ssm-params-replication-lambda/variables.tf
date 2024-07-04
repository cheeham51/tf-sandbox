variable "service_name" {
  type        = string
  description = "The name of the service"
  default     = "ssm-params-replication"
}

variable "replication_source_region" {
  description = "Source region that secrets are replicated from"
  type        = string
  default = "ap-southeast-2"
}

variable "replication_target_region" {
  description = "Target region that secrets are replicated to"
  type        = string
  default     = "ap-southeast-4"
}

variable "log_level" {
  description = "Log level for the lambda"
  default     = "INFO"
  type        = string
}

