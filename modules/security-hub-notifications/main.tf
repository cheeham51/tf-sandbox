terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.dev, aws.security_account]
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}