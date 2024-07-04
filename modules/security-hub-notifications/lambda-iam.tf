resource "aws_iam_role" "lambda_role" {
  provider = aws.dev
  name               = "${local.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  inline_policy {
    name   = "sns_access"
    policy = data.aws_iam_policy_document.access.json
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "access" {
  statement {
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:RotateSecret",
      "secretsmanager:CancelRotateSecret",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "logs:TagLogGroup",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
    ]
    effect    = "Allow"
    resources = [aws_sqs_queue.security_hub_findings_queue.arn]
  }
}

resource "aws_iam_role_policy_attachment" "lambda-basic-exec" {
  provider = aws.dev
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.id
}
