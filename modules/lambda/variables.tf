variable "enable_lambda" {
  description = "For enabling lambda"
  type        = bool
}

variable "vpc_subnets" {
  description = "VPC subnets"
  type        = list(string)
  default     = null
}

variable "vpc_sgs" {
  description = "VPC security groups"
  type        = list(string)
  default     = null
}
