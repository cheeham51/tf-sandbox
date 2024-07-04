resource "aws_iam_role" "lambda_role" {
  name               = "${local.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  inline_policy {
    name   = "ssm-params-access"
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
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:PutParameter",
      "ssm:ListTagsForResource",
      "ssm:AddTagsToResource",
      "ssm:GetParameters"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "logs:TagLogGroup",
      "iam:CreateServiceLinkedRole",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda-basic-exec" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.id
}
