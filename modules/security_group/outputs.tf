output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

output "aurora_sg_id" {
  value = aws_security_group.aurora_sg.id
}

output "codebuild_sg_id" {
  value = aws_security_group.codebuild_sg.id
}