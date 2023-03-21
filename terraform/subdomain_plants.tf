module "subsite_plants" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "plants"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "gml5nup4ce"
  api_gateway_stage = "prod"
}

module "subsite_plants_dev" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "plants.dev"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "mczzirnlx3"
  api_gateway_stage = "prod"
}
