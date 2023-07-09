module "subsite_rcc" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "rcc"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "txkgvwzb3f"
  api_gateway_stage = "prod"
}
