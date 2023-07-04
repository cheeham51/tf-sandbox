variable "env" {
  type        = string
  description = "Environment name"
}

variable "sso_admin_group_id" {
  type        = string
  description = "SSO Admin Group ID"
  default     = "97671efe89-79d99e10-1616-4116-8ef1-3ef2907a6d86"
}

variable "sso_developer_group_id" {
  type        = string
  description = "SSO Developer Group ID"
  default     = "97671efe89-b8fd537a-799b-418c-856d-8655e5736ac4"
}

variable "sso_support_group_id" {
  type        = string
  description = "SSO Support Group ID"
  default     = "97671efe89-8256da3c-87fc-485d-bb8f-c554a2eef4c8"
}

variable "sso_readonly_group_id" {
  type        = string
  description = "SSO ReadOnly Group ID"
  default     = "97671efe89-7c77bf4d-7d2c-487d-81c5-2d78ff71acdf"
}
variable "sso_quality_group_id" {
  type        = string
  description = "SSO Quality Group ID"
  default     = "97671efe89-5b179c7d-ffa5-4be8-9d4f-c853ff565b54"
}

variable "sso_org_unit" {
  type        = string
  description = "SSO Org Unit"
  default     = "ou-gjg6-wo00esyv"
}

variable "route53_zone_id" {
  description = "The Route53 Zone ID"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "vpc_private_subnets" {
  type        = set(string)
  description = "The private subnets for the VPC"
}

# variable "source_bucket_name" {
#   type        = string
#   description = "The bucket to pull the zip from"
# }

variable "api_key_rotation_days" {
  default = 29
}
