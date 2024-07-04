resource "aws_sns_topic" "security_hub_notifications" {
  name = "security_hub_notifications"
  provider = aws.dev
}

# Allow cross-account access to the SNS Topic
resource "aws_sns_topic_policy" "security_hub_notifications_policy" {
  arn    = aws_sns_topic.security_hub_notifications.arn
  policy = data.aws_iam_policy_document.security_hub_notifications_document.json
  provider = aws.dev
}

# Define the policy to allow cross-account access
data "aws_iam_policy_document" "security_hub_notifications_document" {
  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::516161102907:root"] 
    }

    resources = [
      aws_sns_topic.security_hub_notifications.arn,
    ]
  }
}