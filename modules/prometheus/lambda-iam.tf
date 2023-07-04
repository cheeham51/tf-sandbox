# resource "aws_iam_policy" "api_key_rotation_lambda_execution_role_policy" {
#   name   = "api_key_rotation_lambda_execution_role_policy"
#   policy = data.aws_iam_policy_document.api_key_rotation_lambda_execution_role_policy_document.json
# }

# resource "aws_iam_policy_attachment" "api_key_rotation_lambda_execution_role_policy_attachment" {
#   name       = "api_key_rotation_lambda_execution_role_policy_attachment"
#   roles      = [module.grafana_apikey_rotation_handler.lambda_role_name]
#   policy_arn = aws_iam_policy.api_key_rotation_lambda_execution_role_policy.arn
# }

# data "aws_iam_policy_document" "api_key_rotation_lambda_execution_role_policy_document" {
#   statement {
#     sid    = "AllowSecretsManagerGrafanaApiKey"
#     effect = "Allow"
#     actions = [
#       "secretsmanager:DescribeSecret",
#       "secretsmanager:GetSecretValue",
#       "secretsmanager:PutSecretValue",
#       "secretsmanager:UpdateSecretVersionStage",
#       "secretsmanager:UpdateSecret"
#     ]
#     resources = [
#       aws_secretsmanager_secret.key.arn
#     ]
#   }

#   statement {
#     sid    = "AllowManagedGrafanaApiKeyManagement"
#     effect = "Allow"
#     actions = [
#       "grafana:CreateWorkspaceApiKey",
#       "grafana:DeleteWorkspaceApiKey"
#     ]
#     resources = [
#       "arn:aws:grafana:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:/workspaces/${aws_grafana_workspace.workspace.id}"
#     ]
#   }
# }