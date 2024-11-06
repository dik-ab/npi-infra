module "network" {
  source              = "../modules/network"
  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidrs = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones  = var.availability_zones
}

module "alb" {
  source             = "../modules/alb"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  security_group_ids = [module.security_group.alb_sg_id]
}

module "security_group" {
  source               = "../modules/security_group"
  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.network.vpc_id
  allowed_cidr_blocks  = ["0.0.0.0/0"]
}