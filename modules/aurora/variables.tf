# variables.tf

variable "env" {
  type        = string
  description = "The environment to deploy the Aurora cluster in"
}

variable "database_name" {
  type        = string
  description = "The name of the Aurora database"
}

variable "db_subnet_group_name" {
  type        = string
  description = "The name of the DB subnet group for the Aurora database"
}

variable "engine_version" {
  type        = string
  description = "The version of the Aurora database engine"
  default     = "15.2"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy the Aurora cluster in"
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group for the Aurora cluster"
}

variable "monitoring_interval" {
  type        = number
  description = "The interval for CloudWatch monitoring of the Aurora database"
  default     = 0
}

variable "auto_pause" {
  type        = bool
  description = "Whether or not to auto-pause the Aurora database"
  default     = false
}

variable "seconds_until_auto_pause" {
  type        = number
  description = "The number of seconds until the Aurora database is auto-paused"
  default     = 300
}

variable "max_capacity" {
  type        = number
  description = "The maximum capacity of the Aurora database"
  default     = 8
}

variable "min_capacity" {
  type        = number
  description = "The minimum capacity of the Aurora database"
  default     = 1
}

variable "multi_az" {
  type        = bool
  description = "Whether or not to deploy the Aurora database in a multi-AZ configuration"
  default     = true
}

variable "create_security_group" {
  type        = bool
  description = "Whether or not to create a new security group for the Aurora cluster"
  default     = false
}

variable "storage_type" {
  type        = string
  description = "The storage type for the Aurora database"
  default     = "gp2"
}

variable "instance_class" {
  type        = string
  description = "DB Instance Class"
  default     = "db.t3.small"
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created."
  default     = "07:00-09:00"
}

variable "cluster_identifier" {
  type        = string
  description = "The unique name for the database cluster."
  default     = "frankie-rds-cluster"
}

variable "engine" {
  type        = string
  description = "The database engine mode."
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  type        = string
  description = "The database engine mode."
  default     = "provisioned"
}

variable "master_username" {
  type        = string
  description = "The name of the master user for the cluster."
}

variable "master_password" {
  type        = string
  description = "Aurora cluster master_password"
}

variable "backup_retention_period" {
  type        = number
  description = "The number of days to retain automated backups."
  default     = 30
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "The ID of the security group to associate with the cluster."
  default     = []
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of Availability Zones (AZs) where instances in the cluster can be created."
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage"
  default     = 20
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default = {
    "terraform" = "aws-infra-core2"
  }
}

variable "instance_count" {
  type        = number
  description = "The number of instances to create in the cluster."
  default     = 1
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Whether or not to enable performance insights for the Aurora database"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "Define when to perform maintenance in UTC format: ddd:hh24:mi-ddd:hh24:mi - default is 1am Thursday AEST"
  default     = "Thu:15:00-Thu:15:30"
}

variable "dsn" {
  type        = string
  description = "The data source name for the Aurora database"
  default     = "dsn"
}

variable "dsn_regex" {
  type        = string
  description = "The regex to use to extract the secret from dsn string"
  default     = ".*:(.*)@.*"
}

variable "storage_encrypted" {
  type        = bool
  description = "Whether or not to encrypt the Aurora database"
  default     = false
}

variable "additional_security_group_ids" {
  type        = list(string)
  description = "A list of additional security group IDs to attach to the Aurora cluster"
  default     = []
}
