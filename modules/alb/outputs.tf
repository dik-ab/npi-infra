output "target_group_arn" {
  value       = aws_lb_target_group.ecs_tg.arn
  description = "ARN of the target group"
}

output "target_group_name" {
  value       = aws_lb_target_group.ecs_tg.name
  description = "Name of the target group"
}