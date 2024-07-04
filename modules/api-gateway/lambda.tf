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
#   name               = "iam_for_lambda"
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
  filename         = "${path.module}/app.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  function_name    = "apigw-auth"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.10"
  timeout          = 600
  # architectures    = [ "arm64" ]
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_dir = "${path.module}/code"
  output_path = "${path.module}/app.zip"
}