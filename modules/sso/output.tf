output "sso_qa_group_id" {
  value = data.aws_identitystore_group.sso_qa_group.group_id
}

output "sso_admin_group_id" {
  value = data.aws_identitystore_group.sso_admin_group.group_id
}