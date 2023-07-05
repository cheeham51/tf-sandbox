data "aws_iam_policy_document" "code_deploy_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "code_deploy_sam_lambda_iam_role" {
  name               = "code-deploy-sam-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.code_deploy_assume_role.json
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.code_deploy_sam_lambda_iam_role.name
}

resource "aws_codedeploy_app" "sam_lambda_1_app" {
  compute_platform = "Lambda"
  name             = "sam_lambda_1"
}

resource "aws_codedeploy_deployment_config" "sam_lambda_1_deployment_config" {
  deployment_config_name = "same-lambda-1-deployment-config"
  compute_platform       = "Lambda"

  traffic_routing_config {
    type = "TimeBasedLinear"

    time_based_linear {
      interval   = 10
      percentage = 10
    }
  }
}

resource "aws_codedeploy_deployment_group" "sam_lambda_1_deployment_group" {
  app_name               = aws_codedeploy_app.sam_lambda_1_app.name
  deployment_group_name  = "sam_lambda_1_deployment_group"
  service_role_arn       = aws_iam_role.code_deploy_sam_lambda_iam_role.arn
  deployment_config_name = aws_codedeploy_deployment_config.sam_lambda_1_deployment_config.id

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_STOP_ON_ALARM"]
  }
}