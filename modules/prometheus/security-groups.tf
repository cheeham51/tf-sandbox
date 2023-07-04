resource "aws_security_group" "grafana" {
  name        = "grafana-security-group"
  description = "Manages Grafana Access"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "grafana_egress" {
  security_group_id = aws_security_group.grafana.id
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
}
