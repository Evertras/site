module "subsite_golfhands" {
  source = "./modules/subsite"

  subdomain = "golftrainer"
  is_spa    = false

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_golfhands_sync_key_id" {
  value = module.subsite_golfhands.sync_key_id
}

output "subsite_golfhands_sync_key_secret" {
  value     = module.subsite_golfhands.sync_key_secret
  sensitive = true
}
