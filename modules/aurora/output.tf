output "security_group_arn" {
  value = var.create_security_group ? aws_security_group.security_group[0].arn : ""
}

output "security_group_id" {
  value = var.create_security_group ? aws_security_group.security_group[0].id : ""
}

output "security_group_name" {
  value = var.create_security_group ? aws_security_group.security_group[0].name : ""
}

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_cluster_master_username" {
  value = aws_rds_cluster.aurora_cluster.master_username
}

output "aurora_cluster_master_password" {
  value = aws_rds_cluster.aurora_cluster.master_password
}
