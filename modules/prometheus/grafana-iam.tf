resource "aws_iam_role" "assume" {
  name               = "grafana-assume"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  inline_policy {
    name   = "grafana-access"
    policy = data.aws_iam_policy_document.access.json
  }
}

data "aws_iam_policy_document" "assume" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["grafana.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "access" {
  version = "2012-10-17"

  statement {
    sid = "PrometheusAccess"
    actions = [
      "aps:*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "AllowReadingMetricsFromCloudWatch"
    actions = [
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricData"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "AllowReadingLogsFromCloudWatch"
    actions = [
      "logs:DescribeLogGroups",
      "logs:GetLogGroupFields",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:GetQueryResults",
      "logs:GetLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "AllowReadingTagsInstancesRegionsFromEC2"
    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "AllowReadingResourcesForTags"
    actions = [
      "tag:GetResources"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "SNSPublish"
    actions = [
      "sns:Publish"
    ]
    effect    = "Allow"
    resources = ["arn:aws:sns:*:${data.aws_caller_identity.this.account_id}:grafana*"]
  }

}

resource "aws_iam_policy_attachment" "xray" {
  name       = "readonly_assume"
  roles      = [aws_iam_role.assume.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayReadOnlyAccess"
}
