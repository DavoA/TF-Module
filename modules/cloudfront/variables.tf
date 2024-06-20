variable "enable_cloudfront" {
  description = "For enabling Cloudfront"
  type        = bool
}

variable "origin" {
  description = "Cloudfront origin"
  type        = string
}

variable "target_origin" {
  description = "Cloudfront default cache behavior target origin"
  type        = string
}

variable "domain" {
  description = "Cloudfront domain"
  type        = string
}

variable "cloudfront_user_accept_enabled" {
  description = "cloudfront user accept enabled"
  type        = bool
  default     = true
}

variable "cloudfront_ipv6_enabled" {
  description = "cloudfront user ipv6 enabled"
  type        = bool
  default     = true
}

variable "cloudfront_comment" {
  description = "cloudfront comment"
  type        = string
  default     = "My CloudFront Distribution"
}

variable "cloudfront_viewer_protocol_policy" {
  description = "cloudfront viewer protocol policy"
  type        = string
  default     = "allow-all"
}

variable "cloudfront_allowed_methods" {
  description = "cloudfront allowed methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cloudfront_cached_methods" {
  description = "cloudfront cached methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cloudfront_query_string" {
  description = "cloudfront query string"
  type        = bool
  default     = false
}

variable "cloudfront_cookies_forward" {
  description = "cloudfront cookies forward"
  type        = string
  default     = "none"
}

variable "cloudfront_min_ttl" {
  description = "cloudfront min ttl"
  type        = number
  default     = 0
}

variable "cloudfront_default_ttl" {
  description = "cloudfront default ttl"
  type        = number
  default     = 3600
}

variable "cloudfront_max_ttl" {
  description = "cloudfront max ttl"
  type        = number
  default     = 86400
}


variable "cloudfront_restriction_type" {
  description = "cloudfront restriction type"
  type        = string
  default     = "none"
}

variable "cloudfronts_default_certificate" {
  description = "cloudfront default certificate"
  type        = bool
  default     = true
}

variable "cloudfront_role_name" {
  description = "cloudfront role name"
  type        = string
  default     = "CloudFront_S3_Access_Role"
}

variable "cloudfront_policy_name" {
  description = "cloudfront policy name"
  type        = string
  default     = "S3_Access_Policy"
}

variable "cloudfront_policy_attachment_name" {
  description = "cloudfront policy attachment name"
  type        = string
  default     = "s3_policy_attachment"
}

