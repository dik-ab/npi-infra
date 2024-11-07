resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "${var.project_name}-${var.environment}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_mode             = "serverless"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = [var.aurora_security_group_id]

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 8
    min_capacity             = 2
    seconds_until_auto_pause = 300
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-aurora-cluster"
  }
}
