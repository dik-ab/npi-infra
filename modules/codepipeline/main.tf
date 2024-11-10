resource "aws_codestarconnections_connection" "github_connection" {
  name          = "${var.project_name}-${var.environment}-github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "backend_pipeline" {
  name     = "${var.project_name}-${var.environment}-pipeline"
  role_arn = var.role_arn

  artifact_store {
    type     = "S3"
    location = var.artifact_bucket_name
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      provider         = "CodeStarSourceConnection"
      owner            = "ThirdParty"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo}"
        BranchName    = var.github_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.codedeploy_deployment_group_name
      }
    }
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-pipeline"
  }
}
