#Create VPC network with internet gateway and subnet.

module "vpc" {
  source = "./modules/terraform-aws-vpc-module"
  cidr   = var.cidr_block
}

#Create ELB,target groups,listeners.

module "alb" {
  source            = "./modules/terraform-aws-alb-module"
  security_group_id = [module.vpc.security_group_id]
  public_subnet_ids = [module.vpc.public_subnet_id_1, module.vpc.public_subnet_id_2, module.vpc.public_subnet_id_3]
  vpc_id            = module.vpc.vpc_id
}

#Creates an s3 bucket, generates into the bucket more than 1101 objects.

module "s3" {
  source = "./modules/terraform-aws-s3-module"
}

#Creates Lambda function,iam role and policy,lambda function attached to ELB.

module "lambda" {
  source               = "./modules/terraform-aws-lambda-module"
  alb_target_group_arn = module.alb.target_group_arn
}
