output "codedeploy_app_name" {
  value = aws_codedeploy_app.django_app.name
}

output "codedeploy_deployment_group_name" {
  value = aws_codedeploy_deployment_group.django_deployment_group.deployment_group_name
}