resource "aws_grafana_workspace" "workspace" {
  account_access_type      = "ORGANIZATION"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "CUSTOMER_MANAGED"

  # this is from ff accounts structure
  organizational_units = ["r-ngz2"]

  name = var.env

  role_arn = aws_iam_role.assume.arn
  data_sources = [
    "XRAY",
    "CLOUDWATCH",
    "PROMETHEUS",
  ]

  vpc_configuration {
    security_group_ids = [aws_security_group.grafana.id]
    subnet_ids         = var.vpc_private_subnets
  }
}

resource "aws_grafana_workspace_api_key" "key" {
  key_name        = "tf-key"
  key_role        = "ADMIN"
  seconds_to_live = 2592000
  workspace_id    = aws_grafana_workspace.workspace.id
}

resource "aws_grafana_role_association" "admin_association" {
  role         = "ADMIN"
  group_ids    = ["9067b09506-5c7b200e-2cdd-4c0a-8fd6-b7199ac79c99"]
  workspace_id = aws_grafana_workspace.workspace.id
}

# resource "aws_grafana_role_association" "editor_association" {
#   role         = "EDITOR"
#   group_ids    = [var.sso_developer_group_id, var.sso_support_group_id]
#   workspace_id = aws_grafana_workspace.workspace.id
# }

# resource "aws_grafana_role_association" "viewer_association" {
#   role         = "VIEWER"
#   group_ids    = [var.sso_quality_group_id, var.sso_readonly_group_id]
#   workspace_id = aws_grafana_workspace.workspace.id
# }
