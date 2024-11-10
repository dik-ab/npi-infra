module "network" {
  source                = "../modules/network"
  project_name          = var.project_name
  environment           = var.environment
  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones
  ecs_sg_id             = module.security_group.ecs_sg_id
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
  source              = "../modules/security_group"
  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.network.vpc_id
  allowed_cidr_blocks = ["0.0.0.0/0"]
}

module "ecr" {
  source       = "../modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

module "ecs" {
  source                 = "../modules/ecs"
  project_name           = var.project_name
  environment            = var.environment
  django_image           = module.ecr.ecr_repository_url
  django_settings_module = "${var.project_name}.settings.${var.environment}"
  private_subnet_ids     = module.network.private_subnet_ids
  security_group_ids     = [module.security_group.ecs_sg_id]
  target_group_arn       = module.alb.target_group_arn
}

module "aurora" {
  source                   = "../modules/aurora"
  project_name             = var.project_name
  environment              = var.environment
  db_username              = var.db_username
  db_password              = var.db_password
  db_subnet_group_name     = module.network.db_subnet_group_name
  ecs_security_group_id    = module.security_group.ecs_sg_id
  aurora_security_group_id = module.security_group.aurora_sg_id
  instance_count           = "1"
}

module "secrets" {
  source       = "../modules/secrets"
  project_name = var.project_name
  environment  = var.environment
  db_username  = var.db_username
  db_password  = var.db_password
  db_port      = var.db_port
  db_host      = module.aurora.aurora_cluster_endpoint
  db_name      = var.db_name
}

module "iam" {
  source               = "../modules/iam"
  project_name         = var.project_name
  environment          = var.environment
  aurora_cluster_arn   = module.aurora.aurora_cluster_arn
  aurora_instance_arns = module.aurora.aurora_cluster_instance_arns
  secret_arn           = module.secrets.db_credentials_arn
}

module "artifact_bucket" {
  source               = "../modules/s3/artifact_bucket"
  project_name = var.project_name
  environment = var.environment
}

module "codepipeline" {
  source               = "../modules/codepipeline" 
  project_name         = var.project_name
  environment          = var.environment
  github_oauth_token   = var.oauth_token
  github_repo          = var.github_repo
  github_owner         = var.github_owner
  role_arn = module.codepipeline_role.pipeline_role_arn
  artifact_bucket_name = module.s3_artifact_bucket.artifact_bucket_name
}

module "codepipeline_role" {
  source = "../modules/iam/codepipeline_role"
  project_name = var.project_name
  environment = var.environment
}

resource "aws_codebuild_project" "backend_build" {
  name          = "${var.project_name}-${var.environment}-build"
  service_role  = module.codebuild_role.codebuild_service_role_arn
}

module "codebuild_role" {
  source              = "../iam/codebuild_role"
  project_name        = var.project_name
  environment         = var.environment
  artifact_bucket_name = module.s3_artifact_bucket.artifact_bucket_name
}

