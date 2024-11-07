variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Database host address"
  type        = string
}

variable "db_port" {
  description = "Database port number"
  type        = string
  default     = "5432"
}

variable "db_name" {
  description = "Database name"
  type        = string
}
