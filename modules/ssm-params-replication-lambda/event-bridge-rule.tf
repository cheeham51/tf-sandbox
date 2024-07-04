resource "aws_cloudwatch_event_rule" "ssm_parameter_store_change_event_rule" {
  name        = "ssm-parameter-store-change"
  description = "Capture all SSM parameter store changes"

  event_pattern = jsonencode({
    "source" : [
      "aws.ssm"
    ],
    "detail-type" : [
      "Parameter Store Change"
    ]
  })

  tags = {
    "managed_by" = "Terraform"
    "tf_stack"   = "infra-aws-base"
  }
}

resource "aws_cloudwatch_event_bus" "ssm_parameter_store_change_event_bus" {
  name = "ssm-parameter-store-change-event-bus"
}

resource "aws_cloudwatch_event_target" "ssm_parameter_store_change_event_target" {
  rule     = aws_cloudwatch_event_rule.ssm_parameter_store_change_event_rule.name
  arn      = aws_lambda_function.function.arn
  # role_arn = aws_iam_role.security_hub_findings_event_rule_role.arn
}