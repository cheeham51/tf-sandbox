resource "aws_cloudwatch_log_group" "prometheus" {
  name = "${var.env}-prometheus"
}