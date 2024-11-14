resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}-ecs-cluster"
}

resource "aws_ecs_task_definition" "django_task" {
  family                   = "${var.project_name}-${var.environment}-django-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "npi-backend",
      image = "${var.django_image}:latest",
      portMappings = [
        {
          containerPort = 8000,
          hostPort      = 8000
        }
      ],
      environment = [
        { name = "DJANGO_SETTINGS_MODULE", value = var.django_settings_module }
      ],
      secrets = [
        {
          name      = "DATABASE_NAME"
          valueFrom = "${var.db_credentials_arn}:DB_NAME"
        },
        {
          name      = "DATABASE_USER"
          valueFrom = "${var.db_credentials_arn}:DB_USERNAME"
        },
        {
          name      = "DATABASE_PASSWORD"
          valueFrom = "${var.db_credentials_arn}:DB_PASSWORD"
        },
        {
          name      = "DATABASE_HOST"
          valueFrom = "${var.db_credentials_arn}:DB_HOST"
        },
        {
          name      = "DATABASE_PORT"
          valueFrom = "${var.db_credentials_arn}:DB_PORT"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = var.cloudwatch_log_group_name,
          "awslogs-region"        = "ap-northeast-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}


resource "aws_ecs_service" "django_service" {
  name            = "${var.project_name}-${var.environment}-django-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.django_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.blue_target_group_arn
    container_name   = "npi-backend"
    container_port   = 8000
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      load_balancer,
      task_definition
    ]
  }
}
