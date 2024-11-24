resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_record" "alias_record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.subdomain != "" ? "${var.subdomain}.${var.domain_name}" : var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}