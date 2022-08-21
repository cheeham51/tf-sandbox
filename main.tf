locals {
  // locals go here
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25.0"
    }
  }
  backend "s3" {
    encrypt = true
    bucket  = "dtony-tf-state"
    key     = "test.tfstate"
    region  = "ap-southeast-2"
    profile = "home"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  profile = "home"
}

data "aws_caller_identity" "current" {
}