resource "aws_cloudwatch_event_rule" "security_hub_findings" {
  provider    = aws.security_account
  name        = "security-hub-findings-new"
  description = "Capture all Security Hub findings"

  event_pattern = jsonencode({
    "source" : [
      "aws.securityhub"
    ],
    "detail-type" : [
      "Security Hub Findings - Imported"
    ]
  })

  tags = {
    "managed_by" = "Terraform"
    "tf_stack"   = "infra-aws-base"
  }
}

resource "aws_cloudwatch_event_target" "send_to_target_bus" {
  rule      = aws_cloudwatch_event_rule.security_hub_findings.name
  arn       = aws_cloudwatch_event_bus.target_bus.arn
  role_arn  = aws_iam_role.eventbridge_role.arn
}

resource "aws_iam_role" "eventbridge_role" {
  name = "EventBridgeRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "eventbridge_role_policy" {
  name = "EventBridgeRolePolicy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "events:PutEvents",
      Effect = "Allow",
      Resource = aws_cloudwatch_event_bus.target_bus.arn
    }]
  })
}

resource "aws_cloudwatch_event_bus" "target_bus" {
  provider = aws.dev
  name = "target-bus"
}

data "aws_iam_policy_document" "test" {
  statement {
    sid    = "DevAccountAccess"
    effect = "Allow"
    actions = [
      "events:PutEvents",
    ]
    resources = [
      aws_cloudwatch_event_bus.target_bus.arn
    ]

    principals {
      type        = "AWS"
      identifiers = ["516161102907", "616625844834"]
    }
  }
}

resource "aws_cloudwatch_event_bus_policy" "allow_source_account" {
  provider = aws.dev
  policy = data.aws_iam_policy_document.test.json
  event_bus_name = aws_cloudwatch_event_bus.target_bus.name
}

resource "aws_cloudwatch_event_rule" "security_hub_findings_target" {
  provider    = aws.dev
  name        = "security-hub-findings-target"
  description = "Capture all Security Hub findings"
  event_bus_name = aws_cloudwatch_event_bus.target_bus.name

  event_pattern = jsonencode({
    "source" : [
      "aws.securityhub"
    ],
    "detail-type" : [
      "Security Hub Findings - Imported"
    ]
  })

  tags = {
    "managed_by" = "Terraform"
    "tf_stack"   = "infra-aws-base"
  }
}

resource "aws_cloudwatch_event_target" "send_to_target_bus_to_sqs" {
  provider  = aws.dev
  rule      = aws_cloudwatch_event_rule.security_hub_findings_target.name
  target_id = "SendToSQSQueue_to_target_bus"
  arn       = aws_sqs_queue.security_hub_findings_queue.arn
  event_bus_name = aws_cloudwatch_event_bus.target_bus.name
}


