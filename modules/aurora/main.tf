resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "${var.project_name}-${var.environment}-aurora-cluster"
  engine                 = "aurora-postgresql"
  engine_version         = 15.4
  engine_mode            = "provisioned"
  master_username        = var.db_username
  master_password        = var.db_password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.aurora_security_group_id]

  serverlessv2_scaling_configuration {
    min_capacity = 2
    max_capacity = 8
  }

  lifecycle {
    prevent_destroy = false
  }

  final_snapshot_identifier = "${var.project_name}-${var.environment}-final-snapshot"

  tags = {
    Name = "${var.project_name}-${var.environment}-aurora-cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count                = var.instance_count
  identifier           = "${var.project_name}-${var.environment}-aurora-instance-${count.index + 1}"
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  instance_class       = "db.serverless"
  engine               = "aurora-postgresql"
  publicly_accessible  = false
  db_subnet_group_name = var.db_subnet_group_name

  tags = {
    Name = "${var.project_name}-${var.environment}-aurora-instance-${count.index + 1}"
  }
}
