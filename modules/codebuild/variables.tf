variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "The ARN of the service role for CodeBuild"
  type        = string
}

variable "ecr_repository_url" {
  description = "The url of the ECS Repository"
  type        = string
}

variable "docker_hub_username" {
  description = "username of docker hub"
  type        = string
}

variable "docker_hub_token" {
  description = "access token of docker hub"
  type        = string
}

variable "image_uri" {
  description = "ECR Image URI to be used in CodeBuild"
  type        = string
}

variable "execution_role_arn" {
  description = "Execution Role ARN for ECS Task Definition"
  type        = string
}

variable "db_credentials_name" {
  description = "Name of the Secrets Manager secret for database credentials"
  type        = string
}

variable "django_settings_module" {
  description = "Django settings module (e.g., app.settings.production)"
  type        = string
}
