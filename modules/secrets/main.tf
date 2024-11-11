resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${var.project_name}-${var.environment}-db-credentials"

  tags = {
    Name = "${var.project_name}-${var.environment}-db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    DB_USERNAME = var.db_username,
    DB_PASSWORD = var.db_password,
    DB_HOST     = var.db_host,
    DB_PORT     = var.db_port,
    DB_NAME     = var.db_name
  })
}
