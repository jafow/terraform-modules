resource "aws_kms_key" "key" {
  count = var.kms_master_key_arn == "" && var.sse_enabled ? 1 : 0
  description = "KMS key used to encrypt ${var.bucket_name} s3 bucket"
  deletion_window_in_days = var.deletion_window_in_days
  tags = var.tags
}

resource "aws_s3_bucket" "b" {
  count         = var.sse_enabled ? 1 : 0
  bucket = var.bucket_name
  acl    = "private"

  tags = var.tags

  versioning {
    enabled = true
  }

  # https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
  # https://www.terraform.io/docs/providers/aws/r/s3_bucket.html#enable-default-server-side-encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn == "" ? join("", aws_kms_key.key.*.arn) : var.kms_master_key_arn
      }
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "${var.bucket_name}-s3-policy"
    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.b.arn
    ]

    principals {
      type = "AWS"
      identifiers = [var.bucket_principal_arn]
    }

  }
}

resource "aws_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.policy.json
}
