resource "aws_route53_zone" "main" {
  name = "evertras.com"
}

resource "aws_route53_record" "nameservers" {
  allow_overwrite = true

  name    = local.domain
  type    = "NS"
  ttl     = 3600
  zone_id = aws_route53_zone.main.zone_id

  records = aws_route53_zone.main.name_servers
}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id

  name = local.domain

  type = "A"

  alias {
    name    = aws_cloudfront_distribution.site.domain_name
    zone_id = aws_cloudfront_distribution.site.hosted_zone_id

    evaluate_target_health = false
  }
}

output "nameservers" {
  value = aws_route53_zone.main.name_servers
}
