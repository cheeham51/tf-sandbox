locals {
  origin_id = "${aws_api_gateway_rest_api.example.id}.execute-api.ap-southeast-2.amazonaws.com"
}

# data "aws_secretsmanager_secret" "custom_header" {
#   name = "${var.env}/webhook-gateway/cf-headers"
# }

# data "aws_secretsmanager_secret_version" "custom_header" {
#   secret_id = data.aws_secretsmanager_secret.custom_header.id
# }

resource "aws_cloudfront_distribution" "aws_alb_public_cloudfront" {
  tags = {
    "tf-stack" = "infra-aws-backend"
  }
  origin {
    domain_name = "${aws_api_gateway_rest_api.example.id}.execute-api.ap-southeast-2.amazonaws.com"
    origin_id   = local.origin_id
    origin_path = "/prod"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    # custom_header {
    #   name  = jsondecode(data.aws_secretsmanager_secret_version.custom_header.secret_string)["FFSecHeaderName"]
    #   value = jsondecode(data.aws_secretsmanager_secret_version.custom_header.secret_string)["FFSecHeaderValue"]
    # }
    custom_header {
      name  = "x-verfiy-key"
      value = "bababa"
    }
  }

  enabled             = true
  comment             = "CloudFront for webhook API Gateway"

  default_cache_behavior {
    target_origin_id           = local.origin_id
    cache_policy_id            = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled policy ID
    allowed_methods            = [ "DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT" ]
    viewer_protocol_policy     = "https-only"
    cached_methods             = ["GET", "HEAD"]
    response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c" # Managed-SimpleCORS
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
