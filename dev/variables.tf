variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
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

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "codestarconnections_github_connection_arn" {
  type = string
}

variable "docker_hub_username" {
  type = string
}

variable "docker_hub_token" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "action_on_timeout" {
  type = string
}

variable "wait_time_in_minutes" {
  type = number
}

variable "termination_wait_time_in_minutes" {
  type = number
}