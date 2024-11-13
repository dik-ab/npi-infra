variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket for storing pipeline artifacts"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "Branch name for the source code"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role for CodePipeline"
  type        = string
}

variable "codebuild_project_name" {
  description = "The Name of the CodeBuild project name"
  type        = string
}

variable "db_migration_project_name" {
  description = "The name of the Migration CodeBuild project name"
  type        = string
}

variable "codedeploy_app_name" {
  description = "The Name of the CodeDeploy application name"
  type        = string
}

variable "codedeploy_deployment_group_name" {
  description = "The Name of the CodeDeploy deployment group name"
  type        = string
}

variable "codestarconnections_github_connection_arn" {
  type = string
}