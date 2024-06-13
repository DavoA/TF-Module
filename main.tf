module "vpc_module" {
  source     = "./modules/vpc"
  enable_vpc = var.Allow_VPC
}

module "s3_module" {
  source                       = "./modules/s3"
  enable_s3                    = var.Allow_S3
  enable_website_configuration = var.Allow_S3_Website
}

module "ec2_module" {
  source             = "./modules/ec2"
  enable_ec2         = var.Allow_EC2
  public_subnet_id   = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? module.vpc_module.public_subnet_id : var.Default_Subnets[0]
  private_subnet_id  = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? module.vpc_module.private_subnet_id : var.Default_Subnets[1]
  security_group_ids = var.Allow_VPC && var.Allow_Using_VPC_In_EC2 ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "asg_module" {
  source     = "./modules/auto_scaling_group"
  enable_asg = var.Allow_ASG
  my_subnets = var.Allow_VPC && var.Allow_Using_VPC_In_ASG ? [module.vpc_module.public_subnet_id, module.vpc_module.private_subnet_id] : var.Default_Subnets
  my_sgs     = var.Allow_VPC && var.Allow_Using_VPC_In_ASG ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "lb_module" {
  source    = "./modules/load_balancer"
  enable_lb = var.Allow_LB
  my_subnet = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? [module.vpc_module.public_subnet_id] : [var.Default_Subnets[0]]
  my_sgs    = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? [module.vpc_module.security_group_id] : var.Default_SG
  my_vpc    = var.Allow_VPC && var.Allow_Using_VPC_In_LB ? module.vpc_module.vpc_id : var.Default_VPC
}

module "lambda_module" {
  source        = "./modules/lambda"
  enable_lambda = var.Allow_Lambda
  vpc_subnets   = var.Allow_VPC && var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.public_subnet_id] : [var.Default_Subnets[0]]
  vpc_sgs       = var.Allow_VPC && var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "cloudFront_module" {
  source            = "./modules/cloudfront"
  enable_cloudfront = var.Allow_Cloudfront
  domain            = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_domain_name : var.Another_S3_Domain_name
  origin            = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_id : var.Another_S3
  target_origin     = var.Allow_S3 && var.Allow_Using_S3_In_Cloudfront ? module.s3_module.bucket_id : var.Another_S3
}
