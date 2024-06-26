variable "cidr_block" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "availability zones"
  type = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "public_cidr_block" {
  description = "VPC public subnet cidr block"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_cidr_block" {
  description = "VPC private subnet cidr block"
  type        = string
  default     = "10.0.20.0/24"
}

variable "enable_vpc" {
  description = "For enabling VPC"
  type        = bool
}
