variable "sso_instance_arn" {
  type        = string
  description = "The arn of SSO instance"
  default = "arn:aws:sso:::instance/ssoins-7223a5d8a0fd9253"
}

variable "infra_account_id" {
  type        = string
  description = "An AWS account identifier, typically a 10-12 digit string."
  default = "516161102907"
}
