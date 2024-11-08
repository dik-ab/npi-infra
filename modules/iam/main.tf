resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-${var.project_name}-ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.environment}-${var.project_name}-ecs-task-execution-role"
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.environment}-${var.project_name}-ecsTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.environment}-${var.project_name}-ecs-task-execution-role"
  }
}

resource "aws_iam_policy" "ecr_access_policy" {
  name        = "${var.environment}-${var.project_name}-ECRAccessPolicy"
  description = "Policy for ECS to access ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ],
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "${var.environment}-${var.project_name}-ecr-access-policy"
  }
}

resource "aws_iam_policy" "db_access_policy" {
  name        = "${var.environment}-${var.project_name}-DBAccessPolicy"
  description = "Policy for ECS tasks to access Aurora and Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "rds:*"
        ],
        Resource = concat([var.aurora_cluster_arn], var.aurora_instance_arns)
      },
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = [
          var.secret_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_db_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.db_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}