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
  filename      = "${path.root}/modules/s3/python_seed_app.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "app.lambda_handler"

  # source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}