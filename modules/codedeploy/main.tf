resource "aws_codedeploy_app" "django_app" {
  name = "${var.project_name}-${var.environment}-app"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "django_deployment_group" {
  app_name = aws_codedeploy_app.django_app.name
  deployment_group_name = "${var.project_name}-${var.environment}-deployment-group"
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn = var.codedeploy_service_role_arn

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 180
    }

    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.lb_http_listener_arn]
      }

      test_traffic_route {
        listener_arns = [var.lb_http_test_listener_arn]
      }

      target_group {
        name = var.lb_blue_target_group_name
      }

      target_group {
        name = var.lb_green_target_group_name
      }
    }
  }

  auto_rollback_configuration {
    enabled = true
    events = ["DEPLOYMENT_FAILURE"]
  }
}
