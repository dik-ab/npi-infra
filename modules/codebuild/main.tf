resource "aws_codebuild_project" "backend_build" {
  name         = "${var.project_name}-${var.environment}-build"
  service_role = var.codebuild_service_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "REPOSITORY_URL"
      value = var.ecr_repository_url
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "DOCKER_HUB_USERNAME"
      value = var.docker_hub_username
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "DOCKER_HUB_TOKEN"
      value = var.docker_hub_token
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "IMAGE_URI"
      value = var.image_uri
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "EXECUTION_ROLE_ARN"
      value = var.execution_role_arn
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "SECRET_ID"
      value = var.db_credentials_name
      type  = "PLAINTEXT"
    }
    environment_variable {
      name  = "DJANGO_SETTINGS_MODULE"
      value = var.django_settings_module
      type  = "PLAINTEXT"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-build"
  }
}
