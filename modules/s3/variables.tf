variable "enable_s3" {
  description = "For enabling S3"
  type        = bool
}

variable "enable_website_configuration" {
  description = "For enabling website configuration"
  type        = bool
}

variable "enable_s3_object" {
  description = "For enabling uploading s3 object"
  type        = bool
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "my-s3-bucket"
}

variable "s3_html_file" {
  description = "static website html file"
  type        = string
  default     = "index.html"
}

variable "s3_bucket_object_key" {
  description = "s3 bucket object key"
  type        = string
  default     = "example"
}

variable "s3_file_path" {
  description = "s3 object file path"
  type        = string
}

variable "s3_role_name" {
  description = "s3 bucket role name"
  type        = string
  default     = "My-S3-Bucket-Role"
}

variable "s3_policy_name" {
  description = "s3 bucket policy name"
  type        = string
  default     = "s3-putobject-policy"
}
