locals {
  // Get distinct list of domains and SANs
  distinct_domain_names = distinct(concat([var.domain_name], [for s in var.subject_alternative_names : replace(s, "*.", "")]))

  validation_domains = var.enabled ? [for k, v in aws_acm_certificate.cert[0].domain_validation_options : tomap(v) if contains(local.distinct_domain_names, replace(v.domain_name, "*.", ""))] : []
}

resource "aws_acm_certificate" "cert" {
  count = var.enabled ? 1 : 0
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

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
  count = length(local.distinct_domain_names) + 1

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = element(local.validation_domains, count.index)["resource_record_name"]
  type    = element(local.validation_domains, count.index)["resource_record_type"]
  ttl     = var.ttl

  records = [
    element(local.validation_domains, count.index)["resource_record_value"]
  ]

  depends_on = [aws_acm_certificate.cert]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
