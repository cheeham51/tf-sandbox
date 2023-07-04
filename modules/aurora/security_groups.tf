locals {
  security_group_cnt = var.create_security_group ? 1 : 0
}

resource "aws_security_group" "security_group" {
  count = local.security_group_cnt

  description = "Allow access to Aurora PostgreSQL database from private network."
  name        = var.security_group_name
  vpc_id      = var.vpc_id

  tags = {
    "Environment" = var.env,
    "Name"        = var.security_group_name
    "terraform"   = "aws-infra-core2"
    "service"     = "aurora-postgres"
  }

  # ignore changes to ingress and egress rules - other services will attach to this sg
  lifecycle {
    ignore_changes = [egress, ingress]
  }
}
