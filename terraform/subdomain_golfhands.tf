module "subsite_golfhands" {
  source = "./modules/subsite"

  subdomain = "golfhands"
  is_spa    = true

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_golf_sync_key_id" {
  value = module.subsite_golf.sync_key_id
}

output "subsite_golf_sync_key_secret" {
  value     = module.subsite_golf.sync_key_secret
  sensitive = true
}
