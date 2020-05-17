output "main_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "child_zone_id" {
  value = aws_route53_zone.sub.zone_id
}
