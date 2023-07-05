resource "aws_iam_role" "example" {
  name = "test-tf-code-lambda-build"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  role = aws_iam_role.example.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "example" {
  name          = "test-project-1"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "ARM_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "CODEPIPELINE"
    # buildspec        = "codebuild-buildspec.yml"
    buildspec = file("${path.module}/files/deploy-terraform-buildspec.yml")
  }

  tags = {
    Environment = "Test"
  }
}