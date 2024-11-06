resource "aws_ecr_repository" "django_app_repo" {
  name = "${var.project_name}-${var.environment}-django-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "${var.project_name}-${var.environment}-django-repo"
    Environment = var.environment
  }
}

resource "aws_ecr_lifecycle_policy" "django_app_lifecycle" {
  repository = aws_ecr_repository.django_app_repo.name

  policy = <<POLICY
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
POLICY
}
