resource "aws_route53_record" "grafana" {
  name    = "grafana"
  type    = "CNAME"
  zone_id = var.route53_zone_id
  ttl     = 300

  weighted_routing_policy {
    weight = 1
  }

  set_identifier = var.env
  records        = [aws_grafana_workspace.workspace.endpoint]
}