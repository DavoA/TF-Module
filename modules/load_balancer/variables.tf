variable "enable_lb" {
  description = "For enabling load balancer"
  type        = bool
}

variable "my_subnets" {
  description = "For adding desired subnet ids"
  type        = list(string)
}

variable "my_sgs" {
  description = "For adding desired security groups"
  type        = list(string)
}

variable "my_vpc" {
  description = "For adding desired VPC id"
  type        = string
}