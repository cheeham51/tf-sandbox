resource "aws_s3_bucket" "dtony-workspace" {
  bucket = "${terraform.workspace}-dtony-tf-test"
}

resource "aws_s3_bucket_versioning" "dtony_workspace_versioning_configuration" {
  bucket = aws_s3_bucket.dtony-workspace.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dtony-encrypt" {
  bucket = aws_s3_bucket.dtony-workspace.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "destination" {
  provider = aws.melb
  bucket = "${terraform.workspace}-dtony-tf-test-melb"
}

resource "aws_s3_bucket_versioning" "destination_versioning_configuration" {
  provider = aws.melb
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "destination-encrypt" {
  provider = aws.melb
  bucket = aws_s3_bucket.destination.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  # Must have bucket versioning enabled first
  depends_on = [
    aws_s3_bucket_versioning.dtony_workspace_versioning_configuration,
    aws_s3_bucket_versioning.destination_versioning_configuration
  ]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.dtony-workspace.id

  rule {
    id = "foobar"

    filter {}

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
    delete_marker_replication {
      status = "Enabled"
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  name               = "tf-iam-role-replication-12345"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.dtony-workspace.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.dtony-workspace.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination.arn}/*"]
  }
}

resource "aws_iam_policy" "replication" {
  name   = "tf-iam-role-policy-replication-12345"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "null_resource" "deploy_templates" {
    triggers = {
      version = "main"
    }

    provisioner "local-exec" {
      command     = "${path.root}/modules/s3/deploy.sh ${null_resource.deploy_templates.triggers.version} ${aws_s3_bucket.dtony-workspace.id}"
    }
}


# resource "aws_s3_bucket" "dtony_lambda_seeds" {
#   bucket = "dtony-lambda-seeds"
#   force_destroy = true
# }

# resource "aws_s3_bucket_acl" "dtony_lambda_seeds_acl" {
#   bucket = aws_s3_bucket.dtony_lambda_seeds.bucket
#   acl    = "private"
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "dtony_lambda_seeds_encrypt" {
#   bucket = aws_s3_bucket.dtony_lambda_seeds.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_object" "python_lambda_seed" {
#   bucket = aws_s3_bucket.dtony_lambda_seeds.bucket
#   key    = "python_seed_app.zip"
#   source = "${path.root}/modules/s3/python_seed_app.zip"

#   etag = filemd5("${path.root}/modules/s3/python_seed_app.zip")
# }