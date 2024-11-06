terraform {
  backend "s3" {
    bucket         = "npi-state-bucket"
    key            = "dev/npi/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "npi-lock-table"
  }
}