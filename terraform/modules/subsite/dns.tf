resource "aws_route53_record" "site" {
  zone_id = var.hosted_zone_id

  name = local.full_domain

  type = "A"

  alias {
    name    = aws_cloudfront_distribution.site.domain_name
    zone_id = aws_cloudfront_distribution.site.hosted_zone_id

    evaluate_target_health = false
  }
}
