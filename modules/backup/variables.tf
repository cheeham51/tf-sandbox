variable "backup-region" {
  type        = string
  description = "Region that the Backups will be replicated into"
  default     = "ap-southeast-4"
}

variable "backup_replication_enabled" {
  type        = bool
  description = "Toggle to enable replication"
  default     = false
}

variable "daily_backup_schedule" {
  type        = string
  description = "Cron Schedule for backups"
  default     = "cron(45 5 * * ? *)"
}

variable "env_backup_retention" {
  type        = number
  description = "Days till deletion"
  default     = 1
}

/*
variable "cold_time" {
  type        = number
  description = "Days till cold storage"
}
*/