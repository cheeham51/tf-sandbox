terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      # configuration_aliases = [aws.infra]
    }
  }
}

data "aws_caller_identity" "this" {}

data "aws_region" "this" {}