data "aws_iam_policy_document" "s3_access_role_access_policy" {
    provider = aws.development
    statement {
        actions   = ["s3:*"]
        resources = ["*"]
    }
}

data "aws_iam_policy_document" "s3_access_role_for_cross_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::516161102907:role/GitHubActionRole", "arn:aws:iam::516161102907:user/admin"]
    }

  }
}