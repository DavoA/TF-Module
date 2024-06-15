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

variable "lambda_role_name" {
  description = "lambda role name"
  type        = string
  default     = "lambda-role"
}

variable "lambda_filename" {
  description = "lambda filename path"
  type        = string
}

variable "lambda_func_name" {
  description = "lambda function name"
  type        = string
  default     = "My-Lambda-Function"
}

variable "lambdas_handler" {
  description = "lambda handler"
  type        = string
}

variable "lambda_runtime" {
  description = "lambda runtime"
  type        = string
}
