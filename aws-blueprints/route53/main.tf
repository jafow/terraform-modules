resource "aws_route53_zone" "main" {
  name = var.main_zone_name
}

resource "aws_route53_zone" "sub" {
  name = join(".", [var.sub_dns_name, var.main_zone_name])
  tags = var.tags
}

resource "aws_route53_record" "sub_ns" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = join(".", [var.sub_dns_name, var.main_zone_name])
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.sub.name_servers.0}",
    "${aws_route53_zone.sub.name_servers.1}",
    "${aws_route53_zone.sub.name_servers.2}",
    "${aws_route53_zone.sub.name_servers.3}",
  ]
}
