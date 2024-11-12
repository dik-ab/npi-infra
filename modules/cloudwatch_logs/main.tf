resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project_name}-${var.environment}-django"
  retention_in_days = var.retention_in_days
}