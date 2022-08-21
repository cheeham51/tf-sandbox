resource "aws_ssoadmin_account_assignment" "assign_developer_infra" {
  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn

  principal_id   = data.aws_identitystore_group.sso_developers_group.group_id
  principal_type = "GROUP"

  target_id   = var.infra_account_id
  target_type = "AWS_ACCOUNT"
}