module "subsite_bingo" {
  source = "./modules/subsite"

  subdomain = "bingo"
  is_spa    = true

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_bingo_sync_key_id" {
  value = module.subsite_bingo.sync_key_id
}

output "subsite_bingo_sync_key_secret" {
  value     = module.subsite_bingo.sync_key_secret
  sensitive = true
}
