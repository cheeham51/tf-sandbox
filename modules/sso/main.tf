terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_ssoadmin_instances" "sso_instance" {}

data "aws_identitystore_group" "sso_qa_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso_instance.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "QA"
  }
}

data "aws_identitystore_group" "sso_admin_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso_instance.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Admin"
  }
}