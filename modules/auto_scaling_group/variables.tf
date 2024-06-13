variable "enable_asg" {
  description = "For enabling Auto-scaling group"
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

variable "ami_id" {
  description = "Default ami id"
  type        = string
  default     = "ami-033fabdd332044f06"
}

variable "instance_type" {
  description = "Default instance type"
  type        = string
  default     = "t2.micro"
}
