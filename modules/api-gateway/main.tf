locals {
  api_gateway_name = var.webhook_api_gateway_name_override != null ? var.webhook_api_gateway_name_override : "webhook.${var.env}"
  domain           = var.webhook_domain_override != null ? var.webhook_domain_override : terraform.workspace
  log_group        = var.webhook_log_group_override != null ? var.webhook_log_group_override : "webhook-api-log-group-${var.env}"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_route53_zone" "domain" {
  name = "juroxa.com."
}
