variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "artifact_bucket_name" {
  description = "The name of the S3 bucket for artifact storage"
  type        = string
}