terraform {
  backend "s3" {
    bucket         = "${var.project_name}-state-bucket"
    key            = "${var.environment}/${var.project_name}/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "${var.project_name}-${var.environment}-lock-table"
  }
}