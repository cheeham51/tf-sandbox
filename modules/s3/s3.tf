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