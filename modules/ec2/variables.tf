variable "enable_ec2" {
  description = "For enabling ec2 instances"
  type        = bool
}

variable "instance_type" {
  description = "instancce type"
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  description = "Default ami id"
  type        = string
  default     = "ami-033fabdd332044f06"
}

variable "public_subnet_id" {
  description = "Public subnet id"
  type = string
}

variable "private_subnet_id" {
  description = "Public subnet id"
  type = string
}

variable "security_group_ids" {
  description = "security group ids"
  type = list(string)
}

variable "rsa_algorithm" {
  type = string
  default = "RSA"
  description = "Choose key algorithm(RSA, ECDSA, ed25519)"
}

variable "rsa_bit" {
  type = number
  default = 2048
}