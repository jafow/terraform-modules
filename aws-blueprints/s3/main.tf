data "aws_caller_identity" "caller" {}

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
        sse_algorithm     = "AES256"
      }
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "${var.bucket_name}-s3-policy0"
    actions = [
      "s3:*"
    ]

    resources = [join("", aws_s3_bucket.b.*.arn), "${aws_s3_bucket.b.0.arn}/*"]


    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root", var.bucket_principal_arn]
    }

  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = join("", aws_s3_bucket.b.*.id)
  policy = data.aws_iam_policy_document.policy.json
}
