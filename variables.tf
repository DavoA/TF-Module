variable "Allow_VPC" {
  description = "For allowing creating VPC"
  type        = bool
}

variable "Allow_S3" {
  description = "For allowing creating S3"
  type        = bool
}

variable "Allow_S3_Website" {
  description = "For allowing creating S3 static website configuration"
  type        = bool
}

variable "Allow_ASG" {
  description = "For allowing creating Auto Scaling Group"
  type        = bool
}

variable "Allow_LB" {
  description = "For allowing creating Load balancer"
  type        = bool
}

variable "Allow_Lambda" {
  description = "For allowing creating Lambda Function"
  type        = bool
}

variable "Allow_Using_VPC_In_ASG" {
  description = "For allowing using VPC module in ASG"
  type        = bool
}


variable "Allow_Using_VPC_In_LB" {
  description = "For allowing using VPC module in LB"
  type        = bool
}

variable "Allow_Using_VPC_In_Lambda" {
  description = "For allowing using VPC module in Lambda"
  type        = bool
}

### DEFAULT RESOURCE IDS ###
variable "Default_VPC" {
  description = "The default VPC id"
  type        = string
  default     = "vpc-05636725e9d1838a3"
}

variable "Default_Subnets" {
  description = "The default VPC Subnets ids"
  type        = list(string)
  default     = ["subnet-022afa3d806e26dfa", "subnet-0272fa913730c1000", "	subnet-0dafd16068608ae98"]
}

variable "Default_SG" {
  description = "The default VPC Security group id"
  type        = list(string)
  default     = ["sg-02b4202917efd7378"]
}
