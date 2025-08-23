module "subsite_vendomatic" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "vendomatic"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "us0naqm9ab"
  api_gateway_stage = "prod"
}