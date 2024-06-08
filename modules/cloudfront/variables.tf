variable "enable_cloudfront" {
  description = "For enabling Cloudfront"
  type        = bool
}

variable "origin" {
    description = "Cloudfront origin"
    type = string
}

variable "domain" {
    description = "Cloudfront domain"
    type = string
}
