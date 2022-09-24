resource "aws_iam_role" "github_action_role" {
  name               = "GitHubActionRole"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
}

data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "push_images_to_ecr_policy" {
  name   = "allow-github-push-images-to-ecr"
  policy = data.aws_iam_policy_document.push_images_to_ecr_document.json
}

data "aws_iam_policy_document" "push_images_to_ecr_document" {

  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "push_images_to_ecr_role_attachment" {
  role       = aws_iam_role.github_action_role.name
  policy_arn = aws_iam_policy.push_images_to_ecr_policy.arn
}