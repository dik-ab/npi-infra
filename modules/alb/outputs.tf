output "listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "ARN of the ALB listener"
}

output "test_listener_arn" {
  value       = aws_lb_listener.http_test.arn
  description = "ARN of the ALB test listener"
}

output "blue_target_group_arn" {
  value       = aws_lb_target_group.ecs_tg_blue.arn
  description = "ARN of the blue target group for Blue/Green deployments"
}

output "green_target_group_arn" {
  value       = aws_lb_target_group.ecs_tg_green.arn
  description = "ARN of the green target group for Blue/Green deployments"
}

output "lb_blue_target_group_name" {
  description = "The name of the blue target group"
  value       = aws_lb_target_group.ecs_tg_blue.name
}

output "lb_green_target_group_name" {
  description = "The name of the green target group"
  value       = aws_lb_target_group.ecs_tg_green.name
}