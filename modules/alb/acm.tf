data "aws_route53_zone" "main" {
  name         = var.hosted_zone
  private_zone = false
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = data.aws_route53_zone.main.name
  zone_id     = data.aws_route53_zone.main.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${data.aws_route53_zone.main.name}",
  ]

  wait_for_validation = true

  depends_on = [
    data.aws_route53_zone.main
  ]
}
