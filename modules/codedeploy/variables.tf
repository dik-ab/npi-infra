variable "codedeploy_service_role_arn" {
  description = "The ARN of the IAM role for CodeDeploy"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "primary_target_group_name" {
  description = "The name of the primary target group for ECS service"
  type        = string
}

variable "listener_arn" {
  description = "The ARN of the ALB listener"
  type        = string
}
