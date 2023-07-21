data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["*"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.root}/modules/lambda/python_seed_app.zip"
  source_code_hash = filebase64sha256("${path.root}/modules/lambda/python_seed_app.zip")
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "app.lambda_handler"
  runtime = "python3.10"
}

resource "aws_lambda_alias" "lambda_alias" {
  name             = "prod"
  description      = "a sample description"
  function_name    = aws_lambda_function.lambda.arn
  function_version = "1"
}