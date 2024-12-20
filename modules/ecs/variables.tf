variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name, e.g., dev or prod"
  type        = string
}

variable "region" {
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

variable "blue_target_group_arn" {
  description = "ARN of the blue target group for Blue/Green deployments"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the IAM role for ECS task execution"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the IAM role for ECS task role"
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

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Logs group"
  type        = string
}

variable "db_credentials_arn" {
  description = "Arn of db credentials secrets"
  type        = string
}

variable "sender_email" {
  description = "The Sender Email to send email from ses"
  type        = string
}

