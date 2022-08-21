resource "aws_cloudwatch_log_group" "webhook" {
  name              = local.log_group
  retention_in_days = var.cloudwatch_retention_period
}
