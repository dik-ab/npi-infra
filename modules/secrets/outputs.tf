output "db_credentials_arn" {
  description = "ARN of the Secrets Manager secret for database credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_credentials_name" {
  description = "Name of the Secrets Manager secret for database credentials"
  value       = aws_secretsmanager_secret.db_credentials.name
}