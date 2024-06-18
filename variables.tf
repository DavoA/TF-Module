variable "Allow_VPC" {
  description = "For allowing creating VPC"
  type        = bool
}

variable "Allow_EC2" {
  description = "For allowing creating EC2"
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

variable "Allow_S3_Object" {
  description = "For allowing creating S3 object configuration"
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

variable "Allow_EC2_Attachment" {
  description = "For allowing ec2 attachment to load balancer"
  type = bool
}

variable "Allow_Lambda" {
  description = "For allowing creating Lambda Function"
  type        = bool
}

variable "Allow_Cloudfront" {
  description = "For allowing creating Cloudfront distribution"
  type        = bool
}

variable "Allow_Using_VPC_In_ASG" {
  description = "For allowing using VPC module in ASG"
  type        = bool
}

variable "Allow_Using_VPC_In_EC2" {
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

variable "Allow_Using_S3_In_Cloudfront" {
  description = "For allowing using S3 module in Cloudfront"
  type        = bool
}



### ASG ###
variable "ASG_instance_profile_name" {
  description = "instance profile name"
  type = string
  default = "ASG intance profile name"
}

variable "ASG_role_name" {
  description = "ASG role name"
  type = string
  default = "ASG Role"
}

variable "ASG_name" {
  description = "ASG name"
  type = string
  default = "My ASG"
}

variable "ASG_capacity" {
  description = "asg instances desired capasity"
  type = number
  default = 1
}

variable "ASG_min_size" {
  description = "asg instances min size"
  type = number
  default = 1
}

variable "ASG_max_size" {
  description = "asg instances max size"
  type = number
  default = 2
}

variable "ASG_lc_name" {
  description = "ASG LC name"
  type = string
  default = "My lc"
}

### CloudFront ###

variable "Cloudfront_comment" {
  description = "cloudfront comment"
  type = string
  default = "My CloudFront Distribution"
}

variable "Cloudfront_min_ttl" {
  description = "cloudfront min ttl"
  type = number
  default = 0
}

variable "Cloudfront_default_ttl" {
  description = "cloudfront default ttl"
  type = number
  default = 3600
}

variable "Cloudfront_max_ttl" {
  description = "cloudfront max ttl"
  type = number
  default = 86400
}

variable "Cloudfront_role_name" {
  description = "cloudfront role name"
  type = string
  default = "CloudFront_S3_Access_Role"
}

variable "Cloudfront_policy_name" {
  description = "cloudfront policy name"
  type = string
  default = "S3_Access_Policy"
}

variable "Cloudfront_policy_attachment_name" {
  description = "cloudfront policy attachment name"
  type = string
  default = "s3_policy_attachment"
}

### EC2 ###

variable "ec2_file_path" {
  description = "user data file path"
  type = string
}

variable "public_ec2_instances" {
  description = "public instances number"
  type = number
  default = 1
}

variable "private_ec2_instances" {
  description = "private instances number"
  type = number
  default = 1
}

### LB ###

variable "LB_name" {
  description = "load balancer name"
  type = string
  default = "my-load-balancer"
}

variable "LB_target_group_name" {
  description = "load balancer target group name"
  type = string
  default = "my-target-group"
}

variable "EC2_instance_id" {
  description = "ec2 instance id"
  type = string
}

### Lambda ###

variable "Lambda_role_name" {
  description = "lambda role name"
  type = string
  default = "lambda-role"
}

variable "Lambda_filename" {
  description = "lambda filename path"
  type = string
}

variable "Lambda_func_name" {
  description = "lambda function name"
  type = string
  default = "My-Lambda-Function"
}

variable "Lambda_handler" {
  description = "lambda handler"
  type = string
}

variable "Lambda_runtime" {
  description = "lambda runtime"
  type = string
}

### S3 ###

variable "S3_bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "my-s3-bucket"
}

variable "S3_html_file" {
  description = "static website html file"
  type        = string
  default     = "index.html"
}

variable "S3_bucket_object_key" {
  description = "s3 bucket object key"
  type        = string
  default     = "example"
}

variable "S3_file_path" {
  description = "s3 object file path"
  type        = string
}

variable "S3_role_name" {
  description = "s3 bucket role name"
  type        = string
  default     = "My-S3-Bucket-Role"
}

variable "S3_policy_name" {
  description = "s3 bucket policy name"
  type        = string
  default     = "s3-putobject-policy"
}

variable "Another_S3" {
  description = "Another S3 bucket id"
  type = string
  default = ""
}

variable "Another_S3_Domain_name" {
  description = "Another S3 bucket domain name"
  type = string
  default = ""
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

