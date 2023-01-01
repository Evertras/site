module "subsite_" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "sensors"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "sh2cxwrb4b"
  api_gateway_stage = "evertras-home-dashboard"
}
