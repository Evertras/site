resource "aws_cloudfront_distribution" "site" {
  tags = local.tags

  origin {
    domain_name = aws_s3_bucket_website_configuration.site.website_endpoint

    origin_id = local.full_domain

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.full_domain

    min_ttl     = 0
    default_ttl = 300
    max_ttl     = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code            = 404
    response_page_path    = var.is_spa ? "/index.html" : "/404.html"
    response_code         = var.is_spa ? 200 : 404
    error_caching_min_ttl = 300
  }

  aliases = [local.full_domain]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

output "cloudfront_dns" {
  value = aws_cloudfront_distribution.site.domain_name
}
