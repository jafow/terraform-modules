# out
output "bucket_name" {
  value = aws_s3_bucket.b.*.id
}

output "bucket_arn" {
  value = aws_s3_bucket.b.*.arn
}
