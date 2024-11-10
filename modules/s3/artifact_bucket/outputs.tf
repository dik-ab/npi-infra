output "artifact_bucket_name" {
  description = "The name of the S3 bucket for CodePipeline artifacts"
  value       = aws_s3_bucket.pipeline_artifacts.bucket
  export_name = "${var.project_name}-${var.environment}-artifact-bucket"
}