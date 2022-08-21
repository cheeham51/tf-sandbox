locals {
  webhook_validation_options = tolist(aws_acm_certificate.webhook.domain_validation_options)
}

resource "aws_acm_certificate" "webhook" {
  domain_name       = data.aws_route53_zone.domain.name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${data.aws_route53_zone.domain.name}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

// dont loop - these create the same record, then want to destroy the cert
resource "aws_route53_record" "webhook" {
  allow_overwrite = true
  name            = local.webhook_validation_options[0].resource_record_name
  records         = [local.webhook_validation_options[0].resource_record_value]
  ttl             = 300
  type            = local.webhook_validation_options[0].resource_record_type
  zone_id         = data.aws_route53_zone.domain.id
}

resource "aws_acm_certificate_validation" "webhook" {
  certificate_arn         = aws_acm_certificate.webhook.arn
  validation_record_fqdns = [aws_route53_record.webhook.fqdn]
}