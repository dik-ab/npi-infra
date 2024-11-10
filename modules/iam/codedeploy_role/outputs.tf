output "codedeploy_service_role_arn" {
  value = aws_iam_role.codedeploy_service_role.arn
  description = "ARN of the CodeDeploy service role"
}
