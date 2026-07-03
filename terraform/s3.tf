locals {
  payload_filename = "${var.app_name}-payload.zip"
  payload_path     = "${path.module}/${local.payload_filename}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_s3" {
  #checkov:skip=CKV_AWS_109:Root key policy with kms:* is the AWS-recommended pattern for KMS key policies
  #checkov:skip=CKV_AWS_111:Root key policy with kms:* is the AWS-recommended pattern for KMS key policies
  #checkov:skip=CKV_AWS_356:Resource * in a KMS key policy refers to the key itself, not all AWS resources
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_key" "s3" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_s3.json
}

# Logging bucket uses SSE-S3 (KMS not supported for server access logging destinations)
#trivy:ignore:AVD-AWS-0089
#trivy:ignore:AVD-AWS-0132
resource "aws_s3_bucket" "business_card_bucket_logs" {
  bucket = "${var.bucket_name}-logs"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    enabled = true
    expiration {
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
  #checkov:skip=CKV_AWS_18:Logging bucket does not need access logging to avoid circular dependency
  #checkov:skip=CKV_AWS_144:No need to have cross-region replication
  #checkov:skip=CKV_AWS_145:Logging buckets cannot use KMS encryption
  #checkov:skip=CKV2_AWS_62:No need to enable event notifications
}

resource "aws_s3_bucket_public_access_block" "business_card_bucket_logs_access" {
  bucket = aws_s3_bucket.business_card_bucket_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "business_card_bucket_access" {
  bucket = aws_s3_bucket.business_card_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "business_card_bucket" {
  bucket = var.bucket_name
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
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3.arn
      }
    }
  }
  logging {
    target_bucket = aws_s3_bucket.business_card_bucket_logs.id
    target_prefix = "logs/${var.app_name}"
  }
  #checkov:skip=CKV_AWS_144:No need to have cross-region replication
  #checkov:skip=CKV2_AWS_62:No need to enable event notifications
}

resource "aws_s3_bucket_object" "business_card_payload" {
  bucket = aws_s3_bucket.business_card_bucket.id
  key    = "beanstalk/${local.payload_filename}"
  source = local.payload_path
  etag   = filemd5(local.payload_path)
  #checkov:skip=CKV_AWS_186:Object is encrypted via bucket-level KMS key
}
