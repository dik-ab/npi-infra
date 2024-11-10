resource "aws_codebuild_project" "backend_build" {
  name          = "${var.project_name}-${var.environment}-build"
  service_role  = var.codebuild_service_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    environment_variables = [
      {
        name  = "ENVIRONMENT"
        value = var.environment
      },
      {
        name  = "PROJECT_NAME"
        value = var.project_name
      }
    ]
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yml"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-build"
  }
}
