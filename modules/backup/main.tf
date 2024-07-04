terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.backup-region]
    }
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}