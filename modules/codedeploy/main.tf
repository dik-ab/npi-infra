resource "aws_codedeploy_app" "django_app" {
  name = "${var.project_name}-${var.environment}-app"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "django_deployment_group" {
  app_name = aws_codedeploy_app.django_app.name
  deployment_group_name = "${var.project_name}-${var.environment}-deployment-group"
  service_role_arn = var.codedeploy_service_role_arn

  deployment_style {
    deployment_type = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = var.primary_target_group_name
      }
      prod_traffic_route {
        listener_arns = [var.listener_arn]
      }
    }
  }

  auto_rollback_configuration {
    enabled = true
    events = ["DEPLOYMENT_FAILURE"]
  }
}
