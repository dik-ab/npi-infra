output "cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "Name of the ECS cluster"
}

output "service_name" {
  value       = aws_ecs_service.django_service.name
  description = "Name of the ECS service"
}