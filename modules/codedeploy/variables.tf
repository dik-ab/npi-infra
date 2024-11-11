variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

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

variable "listener_arn" {
  description = "The ARN of the ALB listener"
  type        = string
}

variable "lb_http_listener_arn" {
  description = "The ARN of the load balancer's HTTP listener for production traffic"
  type        = string
}

variable "lb_http_test_listener_arn" {
  description = "The ARN of the load balancer's HTTP listener for test traffic"
  type        = string
}

variable "lb_blue_target_group_name" {
  description = "The name of the load balancer's blue target group"
  type        = string
}

variable "lb_green_target_group_name" {
  description = "The name of the load balancer's green target group"
  type        = string
}
