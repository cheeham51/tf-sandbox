variable "env" {
  type        = string
  description = "The environment to deploy to"
  default     = "test"
}

variable "service_name" {
  type        = string
  description = "The name of the service"
  default     = "Security_Hub"
}

variable "log_level" {
  type        = string
  description = "Log level for the lambda function"
  default     = "INFO"
}
