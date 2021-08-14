data "aws_elastic_beanstalk_hosted_zone" "business_card_zone" {
  region = var.aws_region
}

data "aws_route53_zone" "business_card_zone" {
  name = var.dns_name
}

resource "aws_route53_record" "business_card_record" {
  zone_id = data.aws_route53_zone.business_card_zone.zone_id
  name    = data.aws_route53_zone.business_card_zone.name
  type    = "A"
  alias {
    name                   = aws_elastic_beanstalk_environment.default.cname
    zone_id                = data.aws_elastic_beanstalk_hosted_zone.business_card_zone.id
    evaluate_target_health = false
  }
}
