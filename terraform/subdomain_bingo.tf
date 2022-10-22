module "bingo" {
  source = "./modules/subsite"

  subdomain = "bingo"
  is_spa    = true

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "bingo_sync_key_id" {
  value = module.bingo.sync_key_id
}

output "bingo_sync_key_secret" {
  value     = module.bingo.sync_key_secret
  sensitive = true
}
