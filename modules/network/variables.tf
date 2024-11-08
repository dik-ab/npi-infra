variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment name, such as dev or prod"
  type        = string
}

variable "ecs_sg_id" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidrs" {
  type = list(string)
}

variable "private_subnets_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
