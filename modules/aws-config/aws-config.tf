resource "aws_config_configuration_recorder" "default" {
  role_arn = aws_iam_role.aws_config_service_role.arn
}

resource "aws_config_configuration_recorder_status" "default_recorder_status" {
  name       = aws_config_configuration_recorder.default.name
  is_enabled = var.config_recorder_status
  depends_on     = [aws_config_delivery_channel.config_bucket]
}

resource "aws_config_delivery_channel" "config_bucket" {
  s3_bucket_name = var.bucket
  s3_key_prefix = "o-clopwk0vgc"
  depends_on     = [aws_config_configuration_recorder.default, aws_iam_role.aws_config_service_role]
}

data "aws_iam_policy_document" "aws_config_service_role_inline_policy" {
  statement {
    actions   = ["s3:PutObject*"]
    resources = ["*"]
  }
  statement {
    actions   = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "aws_config_service_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws_config_service_role" {
  name = "awsconfig-service-role-${var.alias}"

  inline_policy {
    name   = "my_inline_policy_new"
    policy = data.aws_iam_policy_document.aws_config_service_role_inline_policy.json
  }

  assume_role_policy = data.aws_iam_policy_document.aws_config_service_role_assume_policy.json

   tags = {
    managed-by = "Terraform"
    tf-stack = "infra"
   }
}

resource "aws_iam_role_policy_attachment" "awsconfig-role-policy-attach" {
    role       = aws_iam_role.aws_config_service_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}
