output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.aurora_cluster.endpoint
  description = "The endpoint of the Aurora cluster"
}

output "aurora_cluster_reader_endpoint" {
  value       = aws_rds_cluster.aurora_cluster.reader_endpoint
  description = "The reader endpoint of the Aurora cluster"
}

output "aurora_cluster_id" {
  value       = aws_rds_cluster.aurora_cluster.id
  description = "The ID of the Aurora cluster"
}

output "aurora_db_username" {
  value       = var.db_username
  description = "The username for the Aurora database"
}

output "aurora_db_password" {
  value       = var.db_password
  description = "The password for the Aurora database"
  sensitive   = true
}