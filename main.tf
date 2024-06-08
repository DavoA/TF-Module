module "vpc_module" {
  source     = "./modules/vpc"
  enable_vpc = var.Allow_VPC
}

module "s3_module" {
  source                       = "./modules/s3"
  enable_s3                    = var.Allow_S3
  enable_website_configuration = var.Allow_S3_Website
}

module "asg_module" {
  source     = "./modules/auto_scaling_group"
  enable_asg = var.Allow_ASG
  my_subnets = var.Allow_Using_VPC_In_ASG ? [module.vpc_module.public_subnet_id, module.vpc_module.private_subnet_id] : var.Default_Subnets
  my_sgs     = var.Allow_Using_VPC_In_ASG ? [module.vpc_module.security_group_id] : var.Default_SG
}

module "lb_module" {
  source     = "./modules/load_balancer"
  enable_lb  = var.Allow_LB
  my_subnets = var.Allow_Using_VPC_In_LB ? [module.vpc_module.public_subnet_id, module.vpc_module.private_subnet_id] : var.Default_Subnets
  my_sgs     = var.Allow_Using_VPC_In_LB ? [module.vpc_module.security_group_id] : var.Default_SG
  my_vpc     = var.Allow_Using_VPC_In_LB ? module.vpc_module.vpc_id : var.Default_VPC
}

module "lambda_module" {
  source        = "./modules/lambda"
  enable_lambda = var.Allow_Lambda
  vpc_subnets   = var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.public_subnet_id, module.vpc_module.private_subnet_id] : var.Default_Subnets
  vpc_sgs       = var.Allow_Using_VPC_In_Lambda ? [module.vpc_module.security_group_id] : var.Default_SG
}
