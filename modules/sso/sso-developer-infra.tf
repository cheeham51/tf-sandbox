###########################################################
#### Create DeveloperInfraAccess permission set - BEGIN ###
###########################################################

resource "aws_ssoadmin_permission_set" "infra_developer_permission_set" {
  name             = "DeveloperInfraAccess"
  description      = "Infrastructure account permission set for development team"
  instance_arn     = var.sso_instance_arn
  session_duration = "PT1H"
}

data "aws_iam_policy_document" "infra_developer_permission_set_inline_policy_document" {
  statement {
    sid = "infraDeveloperAccesstoLambdaBucketPolicy"
    actions = [
      "s3:List*",
      "s3:Get*"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::test-tf-bucket-*"
    ]
  }
  statement {
    sid = "infraDeveloperListAllBucketsPolicy"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketAcl",
      "s3:ListAccessPoints",
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::*"
    ]
  }
  statement {
    sid = "infraDeveloperEventBridgeAccess"
    actions = [
      "events:DescribeRule",
      "events:ListRuleNamesByTarget",
      "events:ListRules",
      "events:ListTargetsByRule",
      "events:DescribeEventBus"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:events:::*"
    ]
  }
  statement {
    sid = "infraDeveloperCodePipelineStartPipelineAccess"
    actions = [
      "codepipeline:StartPipelineExecution"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:codepipeline:::*"
    ]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "infra_developer_permission_set_inline_policy" {
  inline_policy      = data.aws_iam_policy_document.infra_developer_permission_set_inline_policy_document.json
  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "infra_developer_permission_set_aws_code_build_read_only_access_policy" {
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "infra_developer_permission_set_aws_code_build_approver_access_policy" {
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess"
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "infra_developer_permission_set_aws_code_pipeline_read_only_access_policy" {
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "infra_developer_permission_set_amazon_ec2_container_registry_read_only_policy" {
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "infra_developer_permission_set_cloudwatch_logs_read_only_access_policy" {
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.infra_developer_permission_set.arn
}

#########################################################
#### Create DeveloperInfraAccess permission set - END ###
#########################################################
