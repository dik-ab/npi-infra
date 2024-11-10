variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "The ARN of the service role for CodeBuild"
  type        = string
}
