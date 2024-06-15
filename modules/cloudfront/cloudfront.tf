resource "aws_cloudfront_distribution" "my_distribution" {
  count = var.enable_cloudfront ? 1 : 0
  origin {
    domain_name = var.domain
    origin_id   = var.origin
    s3_origin_config {
      origin_access_identity = aws_iam_role.cloudfront_s3_access_role[0].arn
    }
  }
  enabled         = var.cloudfront_user_accept_enabled
  is_ipv6_enabled = var.cloudfront_ipv6_enabled
  comment         = var.cloudfront_comment
  default_cache_behavior {
    target_origin_id       = var.target_origin
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy
    allowed_methods        = var.cloudfront_allowed_methods
    cached_methods         = var.cloudfront_cached_methods
    forwarded_values {
      query_string = var.cloudfront_query_string
      cookies {
        forward = var.cloudfront_cookies_forward
      }
    }
    min_ttl     = var.cloudfront_min_ttl
    default_ttl = var.cloudfront_default_ttl
    max_ttl     = var.cloudfront_max_ttl
  }
  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_restriction_type
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = var.cloudfronts_default_certificate
  }
}


resource "aws_iam_role" "cloudfront_s3_access_role" {
  count = var.enable_cloudfront ? 1 : 0
  name  = var.cloudfront_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "cloudfront.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_access_policy" {
  count = var.enable_cloudfront ? 1 : 0
  name  = var.cloudfront_policy_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      Resource = [
        "arn:aws:s3:::*/*"
      ]
    }]
  })
}

resource "aws_iam_policy_attachment" "attach_s3_access_policy" {
  count      = var.enable_cloudfront ? 1 : 0
  name       = var.cloudfront_policy_attachment_name
  roles      = [aws_iam_role.cloudfront_s3_access_role[0].name]
  policy_arn = aws_iam_policy.s3_access_policy[0].arn
}
