# out
output "kms_arn" {
  value = aws_kms_key.key.*.arn
}

output "kms_id" {
  value = aws_kms_key.key.*.id
}

output "bucket_name" {
  value = aws_s3_bucket.b.*.id
}

output "bucket_arn" {
  value = aws_s3_bucket.b.*.arn
}
