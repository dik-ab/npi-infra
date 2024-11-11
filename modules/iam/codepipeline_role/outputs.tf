output "pipeline_role_arn" {
  value       = aws_iam_role.codepipeline_role.arn
  description = "ARN of the CodePipeline IAM Role"
}