module "subsite_stg" {
  source = "./modules/subsite"

  subdomain = "stg"

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_stg_sync_key_id" {
  value = module.subsite_stg.sync_key_id
}

output "subsite_stg_sync_key_secret" {
  value     = module.subsite_stg.sync_key_secret
  sensitive = true
}
