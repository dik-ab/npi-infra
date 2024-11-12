resource "aws_lb" "ecs_lb" {
  name               = "${var.project_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}


resource "aws_lb_target_group" "ecs_tg_blue" {
  name        = "${var.project_name}-${var.environment}-target-group-blue"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-target-group-blue"
  }
}

resource "aws_lb_target_group" "ecs_tg_green" {
  name        = "${var.project_name}-${var.environment}-target-group-green"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-target-group-green"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_blue.arn
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-alb-listener"
  }
}

resource "aws_lb_listener" "http_test" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは「HTTP-test」です"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "prod" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_blue.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  lifecycle {
    ignore_changes = [
      action["target_group_arn"],
    ]
  }
}

resource "aws_lb_listener_rule" "test" {
  listener_arn = aws_lb_listener.http_test.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_green.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  lifecycle {
    ignore_changes = [
      action["target_group_arn"],
    ]
  }
}