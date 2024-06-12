resource "aws_cloudfront_distribution" "my_distribution" {
  count = var.enable_cloudfront ? 1 : 0
  origin {
    domain_name = var.domain
    origin_id   = var.origin
    s3_origin_config {
      origin_access_identity = aws_iam_role.cloudfront_s3_access_role[0].arn
    }
  }
  enabled         = true
  is_ipv6_enabled = true
  comment         = "My CloudFront Distribution"
  default_cache_behavior {
    target_origin_id       = var.target_origin
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


resource "aws_iam_role" "cloudfront_s3_access_role" {
  count = var.enable_cloudfront ? 1 : 0
  name = "CloudFront_S3_Access_Role"
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
  name = "S3_Access_Policy"
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
  count = var.enable_cloudfront ? 1 : 0
  name       = "s3_policy_attachment"
  roles      = [aws_iam_role.cloudfront_s3_access_role[0].name]
  policy_arn = aws_iam_policy.s3_access_policy[0].arn
}
