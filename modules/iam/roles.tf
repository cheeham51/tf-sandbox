resource "aws_iam_role" "s3_access_role_for_cross_assume" {
    provider = aws.development
    name               = "s3-access-role-for-cross-assume"
    assume_role_policy = data.aws_iam_policy_document.s3_access_role_for_cross_assume_policy.json
    inline_policy  {
        name   = "s3_access"
        policy = data.aws_iam_policy_document.s3_access_role_access_policy.json
    }
}