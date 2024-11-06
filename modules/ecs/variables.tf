variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name, e.g., dev or prod"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS tasks"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB target group ARN for ECS service"
  type        = string
}

variable "django_image" {
  description = "Django application Docker image"
  type        = string
}

variable "django_settings_module" {
  description = "Django settings module (e.g., app.settings.production)"
  type        = string
}