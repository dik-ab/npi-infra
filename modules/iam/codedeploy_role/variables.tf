variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}

variable "artifact_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for artifacts"
}
