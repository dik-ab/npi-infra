variable "ecs_security_group_id" {
  type        = string
  description = "Security group ID for ECS to access Aurora"
}

variable "instance_count" {
  type = string
}

variable "db_username" {
  type        = string
  description = "Master username for the Aurora cluster"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "Master password for the Aurora cluster"
  sensitive   = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of the DB subnet group in the private subnet"
}

variable "aurora_security_group_id" {
  type        = string
  description = "List of security group IDs for the Aurora cluster"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment name, such as dev or prod"
  type        = string
}
