variable "region" {
  default     = "ap-southeast-2"
  description = "Region that the Resources will be deployed into"
}

variable "accounts_map" {
  type        = map(string)
  description = "My Accounts"
  default = {
    "home"             = "516161102907"
    "home-dev"         = "616625844834"
  }
}

variable "environment_accounts" {
  type        = list(string)
  description = "My Accounts"
  default = [
    "home"
  ]
}

variable "cidr_map" {
  type        = map(string)
  description = "My Environment Account VPC CIDRs"
  default = {
    "home"  = "10.128.0.0/16"
  }
}

variable "vpc_az" {
  type = list(string)
  default = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c"
  ]
}

####### Test Account ############
variable "home_private_subnet_cidr" {
  type = list(string)
  default = [
    "10.128.32.0/24",
    "10.128.33.0/24",
    "10.128.34.0/24"
  ]
}

variable "home_public_subnet_cidr" {
  type = list(string)
  default = [
    "10.128.0.0/24",
    "10.128.1.0/24",
    "10.128.2.0/24"
  ]
}

variable "home_elasticache_subnet_cidr" {
  type = list(string)
  default = [
    "10.128.221.0/24",
    "10.128.222.0/24",
    "10.128.223.0/24"
  ]
}

variable "home_vpc_elasticache_subnet_group_name" {
  type        = string
  description = "Subnet group name for prod elasticache"
  default     = "redis-vyfpbg"
}

variable "home_db_vpc_cidr" {
  type        = string
  description = "Prod DB VPC CIDR"
  default     = "192.168.0.0/22"
}

variable "home_db_vpc_private_subnet_cidr" {
  type = list(string)
  default = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
}

variable "home_db_vpc_subnet_group_name" {
  type        = string
  description = "Subnet group name for prod databases"
  default     = "portal"
}