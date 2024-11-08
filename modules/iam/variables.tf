variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "aurora_cluster_arn" {
  description = "The ARN of the Aurora cluster"
  type        = string
}

variable "aurora_instance_arns" {
  description = "The ARN of the Aurora instances"
  type        = list(string)
}

variable "secret_arn" {
  description = "The ARN of the Secrets Manager secret"
  type        = string
}
