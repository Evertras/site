resource "aws_acm_certificate" "regional" {
  domain_name = local.domain

  subject_alternative_names = [
    "*.${local.domain}",
    "*.dev.${local.domain}"
  ]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_dns_validation_regional" {
  for_each = {
    for dvo in aws_acm_certificate.regional.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type

  zone_id = aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "regional" {
  provider                = aws.us_east
  certificate_arn         = aws_acm_certificate.site.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_dns_validation_regional : record.fqdn]
}
