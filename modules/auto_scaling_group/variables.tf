variable "enable_asg" {
  description = "For enabling Auto-scaling group"
  type        = bool
}

variable "instance_profile_name" {
  description = "instance profile name"
  type        = string
  default     = "instance profile"
}

variable "asg_role_name" {
  description = "ASG role name"
  type        = string
  default     = "ASG Role"
}

variable "asg_name" {
  description = "ASG name"
  type        = string
  default     = "My ASG"
}

variable "asg_capacity" {
  description = "asg instances desired capasity"
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "asg instances min size"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "asg instances max size"
  type        = number
  default     = 2
}

variable "asg_health_check_type" {
  description = "asg healthcheck type: ES2 or ELB"
  type        = string
  default     = "ES2"
}

variable "asg_health_check_grace_period" {
  description = "asg health check grace period"
  type        = number
  default     = 300
}

variable "asg_forse_delete" {
  description = "asg forse delete"
  type        = bool
  default     = true
}

variable "asg_lc_name" {
  description = "ASG LC name"
  type        = string
  default     = "My lc"
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
