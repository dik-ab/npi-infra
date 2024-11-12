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
  task_role_arn          = module.iam.task_role_arn
  execution_role_arn     = module.iam.execution_role_arn
  django_image           = module.ecr.ecr_repository_url
  django_settings_module = "${var.project_name}.settings.${var.environment}"
  private_subnet_ids     = module.network.private_subnet_ids
  security_group_ids     = [module.security_group.ecs_sg_id]
  blue_target_group_arn  = module.alb.blue_target_group_arn
  cloudwatch_log_group_name         = module.cloudwatch_logs.cloudwatch_log_group_name
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

module "s3_artifact_bucket" {
  source       = "../modules/s3/artifact_bucket"
  project_name = var.project_name
  environment  = var.environment
}

module "codepipeline" {
  source                                    = "../modules/codepipeline"
  project_name                              = var.project_name
  environment                               = var.environment
  github_repo                               = var.github_repo
  github_owner                              = var.github_owner
  github_branch                             = var.github_branch
  codebuild_project_name                    = module.codebuild.codebuild_project_name
  codedeploy_app_name                       = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name          = module.codedeploy.codedeploy_deployment_group_name
  role_arn                                  = module.codepipeline_role.pipeline_role_arn
  artifact_bucket_name                      = module.s3_artifact_bucket.artifact_bucket_name
  codestarconnections_github_connection_arn = var.codestarconnections_github_connection_arn
}

module "codepipeline_role" {
  source       = "../modules/iam/codepipeline_role"
  project_name = var.project_name
  environment  = var.environment
}

module "codebuild" {
  source                     = "../modules/codebuild"
  project_name               = var.project_name
  environment                = var.environment
  aws_region                 = var.aws_region
  codebuild_service_role_arn = module.codebuild_role.codebuild_service_role_arn
  ecr_repository_url         = module.ecr.ecr_repository_url
  docker_hub_username        = var.docker_hub_username
  docker_hub_token           = var.docker_hub_token
  execution_role_arn         = module.iam.execution_role_arn
  image_uri                  = module.ecr.ecr_repository_url
  db_credentials_name        = module.secrets.db_credentials_name
  django_settings_module     = "${var.project_name}.settings.${var.environment}"
}

module "codebuild_role" {
  source               = "../modules/iam/codebuild_role"
  project_name         = var.project_name
  environment          = var.environment
  artifact_bucket_name = module.s3_artifact_bucket.artifact_bucket_name
}

module "codedeploy" {
  source                      = "../modules/codedeploy"
  project_name                = var.project_name
  environment                 = var.environment
  codedeploy_service_role_arn = module.codedeploy_role.codedeploy_service_role_arn
  ecs_cluster_name            = module.ecs.cluster_name
  ecs_service_name            = module.ecs.service_name
  listener_arn                = module.alb.listener_arn
  lb_http_listener_arn        = module.alb.listener_arn
  lb_http_test_listener_arn   = module.alb.test_listener_arn
  lb_blue_target_group_name   = module.alb.lb_blue_target_group_name
  lb_green_target_group_name  = module.alb.lb_green_target_group_name
  action_on_timeout           = var.action_on_timeout
  wait_time_in_minutes        = var.wait_time_in_minutes
  termination_wait_time_in_minutes = var.termination_wait_time_in_minutes
}

module "codedeploy_role" {
  source               = "../modules/iam/codedeploy_role"
  project_name         = var.project_name
  environment          = var.environment
  artifact_bucket_name = module.s3_artifact_bucket.artifact_bucket_name
}

module "cloudwatch_logs" {
  source           = "../modules/cloudwatch_logs"
  project_name     = var.project_name
  environment      = var.environment
  retention_in_days = var.retention_in_days
}
