locals {
  zip_file_name = "${var.service_name}.zip"
  function_name = "${var.env}-${var.service_name}-lambda-new"
}

resource "aws_lambda_function" "securityhub_handler" {
  provider = aws.dev
  function_name    = local.function_name
  filename         = local.zip_file_name
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.9"
  handler          = "lambda_function.lambda_handler"
  timeout          = 600
  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.security_hub_notifications.arn
    }
  }
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = local.zip_file_name
}

# resource "aws_lambda_permission" "allow_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.securityhub_handler.function_name
#   principal     = "sqs.amazonaws.com"
#   source_arn    = aws_sqs_queue.security_hub_findings_queue.arn
# }

resource "aws_lambda_event_source_mapping" "sqs_mapping" {
  provider = aws.dev
  event_source_arn = aws_sqs_queue.security_hub_findings_queue.arn
  function_name    = aws_lambda_function.securityhub_handler.function_name
  batch_size       = 50
  maximum_batching_window_in_seconds = 60
}