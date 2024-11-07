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

module "ecr" {
  source               = "../modules/ecr"
  project_name         = var.project_name
  environment          = var.environment
}

module "ecs" {
  source               = "../modules/ecs"
  project_name         = var.project_name
  environment          = var.environment
  django_image         = module.ecr.ecr_repository_url
  django_settings_module = "${var.project_name}.settings.${var.environment}"
  private_subnet_ids   = module.network.private_subnet_ids
  security_group_ids   = [module.security_group.ecs_sg_id]
  target_group_arn     = module.alb.target_group_arn
}

module "aurora" {
  source                = "../modules/aurora"
  project_name          = var.project_name
  environment           = var.environment
  db_username           = var.db_username
  db_password           = var.db_password
  db_subnet_group_name  = module.network.db_subnet_group_name
  ecs_security_group_id = module.security_group.ecs_sg_id
  aurora_security_group_id = module.security_group.aurora_sg_id
  instance_count           = "1"
}