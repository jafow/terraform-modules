output "acm_arn" {
  description = "arn of the certificate"
  value       = aws_acm_certificate.cert.*.arn
}

output "domain" {
  description = "domain"
  value       = aws_acm_certificate.cert.*.domain_name
}
