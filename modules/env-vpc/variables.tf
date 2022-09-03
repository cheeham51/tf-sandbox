variable "env" {
  description = "The environment name for this VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr block to use for the VPC"
}

variable "vpc_az" {
  type = list(string)
  default = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c"
  ]
}

variable "vpc_private_subnet_cidr" {
  type = list(string)
}

variable "vpc_public_subnet_cidr" {
  type = list(string)
}

variable "vpc_elasticache_subnet_cidr" {
  type    = list(string)
  default = []
}

variable "vpc_elasticache_subnet_group_name" {
  description = "Subnet group name for elasticache"
}

variable "provision_db_vpc" {
  type        = bool
  description = "Whether to provision the DB VPC or not"
  default     = true
}

variable "db_vpc_cidr" {
  type        = string
  description = "DB VPC CIDR"
}

variable "db_vpc_private_subnet_cidr" {
  type        = list(string)
  description = "DB VPC Subnet CIDRs"
}

variable "db_vpc_database_subnet_group_name" {
  description = "Subnet group name for database"
}