module "aws-config" {
  source = "./modules/aws-config"
  config_recorder_status = true
  alias = ""
  bucket = "dtony-log-archive-bucket"
}

module "aws-config-main-use1" {
  source = "./modules/aws-config"
  providers = {
    aws = aws.sso
  }
  config_recorder_status = true
  alias = "sso"
  bucket = "dtony-log-archive-bucket"
}

module "aws-config-dev" {
  source = "./modules/aws-config"
  providers = {
    aws = aws.development
  }
  config_recorder_status = true
  alias = "development"
  bucket = "dtony-log-archive-bucket"
}

module "aws-config-dev-use1" {
  source = "./modules/aws-config"
  providers = {
    aws = aws.development-use1
  }
  config_recorder_status = true
  alias = "development-use1"
  bucket = "dtony-log-archive-bucket"
}


// AWS Config Aggregagor

resource "aws_config_configuration_aggregator" "organization" {
  depends_on = [aws_iam_role_policy_attachment.organization]

  name = "AwsConfigAggregator"

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.organization.arn
  }
}

resource "aws_iam_role" "organization" {
  name = "aws-config-aggregator-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "organization" {
  role       = aws_iam_role.organization.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}