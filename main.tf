locals {
  // locals go here
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
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

provider "aws" {
  alias   = "sso"
  region  = "us-east-1"
  profile = "home"
}

provider "aws" {
  region = "ap-southeast-2"
  alias  = "development"
  assume_role {
    role_arn = "arn:aws:iam::616625844834:role/InfraAdminAccess"
  }
}

data "aws_caller_identity" "current" {
}