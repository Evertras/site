module "subsite_slides_concurrency" {
  source = "./modules/subsite"

  subdomain = "concurrency"
  is_spa    = true

  acm_certificate_arn = aws_acm_certificate.site.arn
  hosted_zone_id      = aws_route53_zone.main.zone_id
}

output "subsite_slides_concurrency_sync_key_id" {
  value = module.subsite_slides_concurrency.sync_key_id
}

output "subsite_slides_concurrency_sync_key_secret" {
  value     = module.subsite_slides_concurrency.sync_key_secret
  sensitive = true
}
