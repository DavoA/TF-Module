module "vpc_module" {
  source     = "./modules/vpc"
  enable_vpc = var.Allow_VPC
}

module "s3_module" {
  source                       = "./modules/s3"
  enable_s3                    = var.Allow_S3
  s3_bucket_name               = var.S3_bucket_name
  s3_role_name                 = var.S3_role_name
  s3_policy_name               = var.S3_policy_name
  enable_website_configuration = var.Allow_S3_Website
  s3_html_file                 = var.S3_html_file
  enable_s3_object             = var.Allow_S3_Object
  s3_bucket_object_key         = var.S3_bucket_object_key
  s3_file_path                 = var.S3_file_path
}

module "ec2_module" {
  source             = "./modules/ec2"
  enable_ec2         = var.Allow_EC2
  public_subnet_id   = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? module.vpc_module.public_subnet_id : var.Default_Subnets[0]
  private_subnet_id  = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? module.vpc_module.private_subnet_id : var.Default_Subnets[1]
  public_instances   = var.public_ec2_instances
  private_instances  = var.private_ec2_instances
  security_group_ids = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? [module.vpc_module.security_group_id] : var.Default_SG
  file_path          = var.ec2_file_path
}

module "asg_module" {
  source        = "./modules/auto_scaling_group"
  enable_asg    = var.Allow_ASG
  asg_name      = var.ASG_name
  asg_role_name = var.ASG_role_name
  asg_capacity  = var.ASG_capacity
  asg_min_size  = var.ASG_min_size
  asg_max_size  = var.ASG_max_size
  asg_lc_name   = var.ASG_lc_name
  my_subnets    = var.Allow_VPC && var.Allow_Using_VPC_In_ASG ? [module.vpc_module.public_subnet_id, module.vpc_module.private_subnet_id] : var.Default_Subnets
  my_sgs        = var.Allow_VPC && var.Allow_Using_VPC_In_ASG ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "lb_module" {
  source                = "./modules/load_balancer"
  enable_lb             = var.Allow_LB
  enable_ec2_attachment = var.Allow_EC2_Attachment
  ec2_instance_id       = var.EC2_instance_id
  my_subnet             = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? [module.vpc_module.public_subnet_id] : [var.Default_Subnets[0]]
  my_sgs                = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? [module.vpc_module.security_group_id] : var.Default_SG
  my_vpc                = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? module.vpc_module.vpc_id : var.Default_VPC
}

module "lambda_module" {
  source           = "./modules/lambda"
  enable_lambda    = var.Allow_Lambda
  lambda_filename  = var.Lambda_filename
  lambda_func_name = var.Lambda_func_name
  lambda_role_name = var.Lambda_role_name
  lambda_runtime   = var.Lambda_runtime
  lambdas_handler  = var.Lambda_handler
  vpc_subnets      = var.Allow_VPC && var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.public_subnet_id] : [var.Default_Subnets[0]]
  vpc_sgs          = var.Allow_VPC && var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "cloudFront_module" {
  source                            = "./modules/cloudfront"
  enable_cloudfront                 = var.Allow_Cloudfront
  cloudfront_comment                = var.Cloudfront_comment
  cloudfront_min_ttl                = var.Cloudfront_min_ttl
  cloudfront_default_ttl            = var.Cloudfront_default_ttl
  cloudfront_max_ttl                = var.Cloudfront_max_ttl
  cloudfront_role_name              = var.Cloudfront_role_name
  cloudfront_policy_name            = var.Cloudfront_policy_name
  cloudfront_policy_attachment_name = var.Cloudfront_policy_attachment_name
  domain                            = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_domain_name : var.Another_S3_Domain_name
  origin                            = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_id : var.Another_S3
  target_origin                     = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_id : var.Another_S3
}
