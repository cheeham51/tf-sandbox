resource "aws_prometheus_workspace" "workspace" {
  alias = "${var.env}-workspace"

  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus.arn}:*"
  }

  tags = {
    Environment = var.env
  }
}
