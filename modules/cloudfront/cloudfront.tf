resource "aws_cloudfront_distribution" "my_distribution" {
  count = var.enable_cloudfront ? 1 : 0
  origin {
    domain_name = var.domain
    origin_id   = var.origin
  }
  enabled         = true
  is_ipv6_enabled = true
  comment         = "My CloudFront Distribution"
  default_cache_behavior {
    target_origin_id       = var.origin
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
