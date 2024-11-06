output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.django_app_repo.repository_url
}