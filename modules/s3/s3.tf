resource "aws_s3_bucket" "dtony-workspace" {
  bucket = "${terraform.workspace}-dtony-tf-test"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dtony-encrypt" {
  bucket = aws_s3_bucket.dtony-workspace.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "null_resource" "deploy_templates" {
    triggers = {
      version = "main"
    }

    provisioner "local-exec" {
      command     = "${path.root}/modules/s3/deploy.sh ${null_resource.deploy_templates.triggers.version} ${aws_s3_bucket.dtony-workspace.id}"
    }
}


resource "aws_s3_bucket" "dtony_lambda_seeds" {
  bucket = "dtony-lambda-seeds"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dtony_lambda_seeds_encrypt" {
  bucket = aws_s3_bucket.dtony_lambda_seeds.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "python_lambda_seed" {
  bucket = aws_s3_bucket.dtony_lambda_seeds.bucket
  key    = "python_seed_app.zip"
  source = "${path.root}/modules/s3/python_seed_app.zip"

  etag = filemd5("${path.root}/modules/s3/python_seed_app.zip")
}