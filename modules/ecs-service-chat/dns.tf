data "aws_route53_zone" "main" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "ts" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    name    = var.alb_domain
    zone_id = var.alb_zone_id

    evaluate_target_health = false
  }
}
