output "codebuild_service_role_arn" {
  description = "The ARN of the CodeBuild service role"
  value       = aws_iam_role.codebuild_service_role.arn
}