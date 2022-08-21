resource "aws_api_gateway_rest_api" "webhook-api" {
  name                     = local.api_gateway_name
  minimum_compression_size = 5000
}

resource "aws_api_gateway_domain_name" "webhook-api" {
  regional_certificate_arn = aws_acm_certificate_validation.webhook.certificate_arn
  domain_name              = "webhook.${data.aws_route53_zone.domain.name}"
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}

resource "aws_api_gateway_base_path_mapping" "webhook-api" {
  api_id      = aws_api_gateway_rest_api.webhook-api.id
  stage_name  = aws_api_gateway_stage.webhook-api.stage_name
  domain_name = aws_api_gateway_domain_name.webhook-api.domain_name
}

resource "aws_api_gateway_stage" "webhook-api" {
  deployment_id = aws_api_gateway_deployment.webhook-api.id
  rest_api_id   = aws_api_gateway_rest_api.webhook-api.id
  stage_name    = "prod"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.webhook.arn
    format          = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] \"$context.httpMethod $context.resourcePath $context.protocol\" $context.status $context.responseLength $context.requestId"
  }
}

resource "aws_api_gateway_resource" "webhook-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.webhook-api.id
  parent_id   = aws_api_gateway_rest_api.webhook-api.root_resource_id
  path_part   = "fftest"
}

# resource "aws_api_gateway_method" "webhook-api-get" {
#   rest_api_id   = aws_api_gateway_rest_api.webhook-api.id
#   resource_id   = aws_api_gateway_resource.webhook-api-resource.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "MyDemoIntegration" {
#   rest_api_id   = aws_api_gateway_rest_api.webhook-api.id
#   resource_id   = aws_api_gateway_resource.webhook-api-resource.id
#   http_method          = aws_api_gateway_method.webhook-api-get.http_method
#   type                 = "MOCK"

#   request_parameters = {
#     "integration.request.header.X-Authorization" = "'static'"
#   }

#   # Transforms the incoming XML request to JSON
#   request_templates = {
#     "application/xml" = <<EOF
# {
#    "body" : $input.json('$')
# }
# EOF
#   }
# }

resource "aws_api_gateway_deployment" "webhook-api" {
  rest_api_id = aws_api_gateway_rest_api.webhook-api.id

  # depends_on = [
  #   aws_api_gateway_method.webhook-api-get,
  #   aws_api_gateway_integration.MyDemoIntegration
  # ]

  lifecycle {
    create_before_destroy = true
  }
}

