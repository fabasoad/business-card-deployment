locals {
  bucket_name  = "business-card-bucket"
  payload_path = "${path.module}/${var.app_name}-payload.zip"
}

resource "aws_s3_bucket_public_access_block" "business_card_bucket_access" {
  bucket = aws_s3_bucket.business_card_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "business_card_bucket" {
  bucket = local.bucket_name
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true
    noncurrent_version_expiration {
      days = 90
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  dynamic "logging" {
    for_each = []
    content {
      target_bucket = logging.value["target_bucket"]
      target_prefix = "logs/${local.bucket_name}"
    }
  }
  #checkov:skip=CKV_AWS_144:No need to have cross-region replication
  #checkov:skip=CKV_AWS_145:No need to encrypt with KMS
}

resource "aws_s3_bucket_object" "business_card_payload" {
  bucket = aws_s3_bucket.business_card_bucket.id
  key    = "beanstalk/${var.app_name}-payload.zip"
  source = local.payload_path
}
