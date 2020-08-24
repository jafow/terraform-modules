resource "aws_acm_certificate" "cert" {
  # count = var.enabled ? 1 : 0
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

# resource "aws_route53_record" "cert_validation" {
#   count = length(var.subject_alternative_names) > 0 ? length(var.subject_alternative_names) + 1 : 1

#   name    = lookup(aws_acm_certificate.cert.0.domain_validation_options[count.index], "resource_record_name")
#   type    = lookup(aws_acm_certificate.cert.0.domain_validation_options[count.index], "resource_record_type")
#   records = [lookup(aws_acm_certificate.cert.0.domain_validation_options[count.index], "resource_record_value")]

#   allow_overwrite = true
#   zone_id = data.aws_route53_zone.zone.zone_id
#   ttl     = var.ttl
# }

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = join("", aws_acm_certificate.cert.*.arn)
#   validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn
# }

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

