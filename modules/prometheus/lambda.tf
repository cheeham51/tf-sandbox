# locals {
#   function_name  = "${terraform.workspace}-grafana-api-key-rotation"
#   script_version = "latest"
# }

# module "grafana_apikey_rotation_handler" {
#   source = "git::git@bitbucket.org:ff_infrastructure/terraform-modules.git//modules/lambda-zip?ref=1.56"
#   env    = terraform.workspace

#   lambda_bucket   = var.source_bucket_name
#   service_name    = local.function_name
#   service_version = "latest"

#   handler          = "rotate.lambda_handler"
#   runtime          = "python3.9"
#   zip_filename     = aws_s3_object.rotation_handler.key
#   source_code_hash = data.archive_file.zip_rotation_handler.output_base64sha256
#   timeout          = 10

#   environment_variables = {
#     GRAFANA_API_SECRET_ARN = aws_secretsmanager_secret.key.arn
#     GRAFANA_API_KEY_NAME   = "${terraform.workspace}-tf-api-key"
#     GRAFANA_WORKSPACE_ID   = aws_grafana_workspace.workspace.id
#   }

#   depends_on = [aws_s3_object.rotation_handler]
# }

# data "archive_file" "zip_rotation_handler" {
#   type             = "zip"
#   source_dir       = "${path.module}/scripts/"
#   output_file_mode = "0666"
#   output_path      = "${path.module}/archive/lambda.zip"
# }

# resource "aws_s3_object" "rotation_handler" {
#   provider   = aws.infra
#   depends_on = [data.archive_file.zip_rotation_handler]
#   bucket     = var.source_bucket_name
#   key        = "release/grafana-api-key-rotation/grafana-api-key-rotation-${local.script_version}.zip"
#   source     = data.archive_file.zip_rotation_handler.output_path
#   etag       = data.archive_file.zip_rotation_handler.output_md5
# }

# resource "aws_lambda_permission" "secrets_manager_api_key_rotation" {
#   statement_id  = "AllowExecutionFromSecretsManager"
#   action        = "lambda:InvokeFunction"
#   function_name = local.function_name
#   principal     = "secretsmanager.amazonaws.com"
# }

# resource "aws_secretsmanager_secret_rotation" "api_key" {
#   secret_id           = aws_secretsmanager_secret.key.id
#   rotation_lambda_arn = module.grafana_apikey_rotation_handler.lambda_arn

#   rotation_rules {
#     automatically_after_days = var.api_key_rotation_days
#   }
# }