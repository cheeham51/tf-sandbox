locals {
  aws_account_region_sets = [
    { "alias": "sso", "config_recorder_status": false},
    { "alias": "", "config_recorder_status": false},
    { "alias": "development", "config_recorder_status": false},
    { "alias": "development-use1", "config_recorder_status": false},
  ]
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

provider "aws" {
  region = "us-east-1"
  alias  = "development-use1"
  assume_role {
    role_arn = "arn:aws:iam::616625844834:role/InfraAdminAccess"
  }
}

data "aws_caller_identity" "current" {
}