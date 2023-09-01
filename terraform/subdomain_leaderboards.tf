module "subsite_leaderboard" {
  source = "./modules/subsite"

  subdomain = "leaderboard"
  is_spa    = true

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_leaderboard_sync_key_id" {
  value = module.subsite_leaderboard.sync_key_id
}

output "subsite_leaderboard_sync_key_secret" {
  value     = module.subsite_leaderboard.sync_key_secret
  sensitive = true
}

module "subsite_leaderboard_api" {
  source = "./modules/subsite_api_gateway_v2"

  subdomain = "leaderboard-api"

  acm_certificate_arn = aws_acm_certificate.regional.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id

  api_gateway_id    = "5xrn94egt4"
  api_gateway_stage = "prod"
}
