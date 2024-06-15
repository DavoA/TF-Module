variable "enable_lb" {
  description = "For enabling load balancer"
  type        = bool
}

variable "enable_ec2_attachment" {
  description = "For enabling ec2 attachment"
  type        = bool
}

variable "my_subnet" {
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

variable "lb_name" {
  description = "load balancer name"
  type        = string
  default     = "my-load-balancer"
}

variable "load_balancer_type" {
  description = "load balancer type"
  type        = string
  default     = "application"
}

variable "lb_target_group_name" {
  description = "load balancer target group name"
  type        = string
  default     = "my-target-group"
}

variable "lb_target_group_port" {
  description = "load balancer target group port"
  type        = number
  default     = 80
}

variable "lb_target_group_protocol" {
  description = "load balancer target group protocol"
  type        = string
  default     = "HTTP"
}

variable "lb_target_group_target_type" {
  description = "load balancer target group target type"
  type        = string
  default     = "instance"
}

variable "lb_listener_port" {
  description = "lb listener port"
  type        = string
  default     = "80"
}

variable "listener_default_action_type" {
  description = "listener default action type"
  type        = string
  default     = "forward"
}

variable "ec2_instance_id" {
  description = "ec2 instance id"
  type        = string
}

variable "attachment_port" {
  description = "ec2 attachment port"
  type        = number
  default     = 80
}
