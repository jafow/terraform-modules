resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  name         = var.route53_zone_name
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  count = length(var.subject_alternative_names) > 0 ? length(var.subject_alternative_names) + 1 : 1
  name    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")
  type    = lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")
  zone_id = join("", data.aws_route53_zone.zone.*.zone_id)
  records = [lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")]
  ttl     = var.ttl
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = join("", aws_acm_certificate.cert.*.arn)
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
}
