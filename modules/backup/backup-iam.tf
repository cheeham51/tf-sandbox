resource "aws_iam_role" "aws_backup_role" {
  name               = "AWSBackupDefaultServiceRole"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  path               = "/service-role/"
  description        = "Provides AWS Backup permission to create backups and perform restores on your behalf across AWS services."

  inline_policy {
    name   = "s3-backup-policy"
    policy = data.aws_iam_policy_document.s3_access.json
  }

  inline_policy {
    name   = "s3-restore-policy"
    policy = data.aws_iam_policy_document.s3_restore.json
  }

  inline_policy {
    name   = "backup-key-access"
    policy = data.aws_iam_policy_document.kms_access.json
  }
}

resource "aws_iam_role_policy_attachment" "backup_access" {
  role       = aws_iam_role.aws_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore_access" {
  role       = aws_iam_role.aws_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["backup.amazonaws.com"]
      type        = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    sid    = "S3BucketBackupPermissions"
    effect = "Allow"
    actions = [
      "s3:GetInventoryConfiguration",
      "s3:PutInventoryConfiguration",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetBucketNotification",
      "s3:PutBucketNotification",
      "s3:GetBucketLocation",
      "s3:GetBucketTagging"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    sid    = "S3ObjectBackupPermissions"
    effect = "Allow"
    actions = [
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion"
    ]
    resources = [
      "arn:aws:s3:::*/*"
    ]
  }

  statement {
    sid    = "S3GlobalPermissions"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "KMSBackupPermissions"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringLike"
      values   = ["s3.*.amazonaws.com"]
      variable = "kms:ViaService"
    }
  }

  statement {
    sid    = "EventsPermissions"
    effect = "Allow"
    actions = [
      "events:DescribeRule",
      "events:EnableRule",
      "events:PutRule",
      "events:DeleteRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:ListTargetsByRule",
      "events:DisableRule"
    ]
    resources = [
      "arn:aws:events:*:*:rule/AwsBackupManagedRule*"
    ]
  }

  statement {
    sid    = "EventsMetricsGlobalPermissions"
    effect = "Allow"
    actions = [
      "cloudwatch:GetMetricData",
      "events:ListRules"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "s3_restore" {
  statement {
    sid    = "S3BucketRestorePermissions"
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetBucketLocation",
      "s3:PutBucketVersioning"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    sid    = "S3ObjectRestorePermissions"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:DeleteObject",
      "s3:PutObjectVersionAcl",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      "arn:aws:s3:::*/*"
    ]
  }

  statement {
    sid    = "S3KMSPermissions"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringLike"
      values   = ["s3.*.amazonaws.com"]
      variable = "kms:ViaService"
    }
  }
}

data "aws_iam_policy_document" "kms_access" {
  statement {
    sid       = "KMSPermissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
  }
}