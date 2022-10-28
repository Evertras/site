resource "aws_apigatewayv2_domain_name" "api_gw" {
  domain_name = local.full_domain

  domain_name_configuration {
    certificate_arn = var.acm_certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_route53_record" "site" {
  zone_id = var.hosted_zone_id

  name = aws_apigatewayv2_domain_name.api_gw.domain_name

  type = "A"

  alias {
    name    = aws_apigatewayv2_domain_name.api_gw.domain_name_configuration[0].target_domain_name
    zone_id = aws_apigatewayv2_domain_name.api_gw.domain_name_configuration[0].hosted_zone_id

    evaluate_target_health = false
  }
}

resource "aws_apigatewayv2_api_mapping" "api" {
  api_id      = var.api_gateway_id
  domain_name = aws_apigatewayv2_domain_name.api_gw.id
  stage       = var.api_gateway_stage
}
