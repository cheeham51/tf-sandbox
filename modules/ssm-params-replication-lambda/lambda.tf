locals {
  zip_file_name = "${var.service_name}.zip"
  function_name = "${var.service_name}-lambda"
}

resource "aws_lambda_function" "function" {
  function_name    = local.function_name
  filename         = local.zip_file_name
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.10"
  handler          = "lambda_function.lambda_handler"
  timeout          = 300
  environment {
    variables = {
      REPLICATION_SOURCE_REGION = var.replication_source_region
      REPLICATION_TARGET_REGION = var.replication_target_region
      LOG_LEVEL                 = var.log_level
    }
  }
  tags = {
    version    = "LATEST"
    managed_by = "Terraform"
    tf_stack   = "infra-aws-base"
  }
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = local.zip_file_name
}

resource "aws_lambda_permission" "allow_events_bridge_to_run_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "events.amazonaws.com"
}
