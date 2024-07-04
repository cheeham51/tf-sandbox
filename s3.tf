module "test-s3" {
  source = "./modules/s3"
  providers = {
    aws.melb = aws.melb
  }
}

resource "aws_s3_bucket" "config-bucket-dev" {
  
  bucket = "config-bucket-616625844834-1"
  provider = aws.development
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config-bucket-main-encrypt" {
  bucket = aws_s3_bucket.config-bucket-dev.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  provider = aws.development
}