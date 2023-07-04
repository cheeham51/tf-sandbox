# resource "aws_secretsmanager_secret" "key" {
#   name = "${var.env}/grafana/key"
# }

# resource "aws_secretsmanager_secret_version" "key" {
#   secret_id     = aws_secretsmanager_secret.key.id
#   secret_string = aws_grafana_workspace_api_key.key.key

#   lifecycle {
#     ignore_changes = [secret_string, secret_id]
#   }
# }