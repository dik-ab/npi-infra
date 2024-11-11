output "codebuild_project_name" {
  value       = aws_codebuild_project.backend_build.name
  description = "The name of the CodeBuild project for the backend build."
}
