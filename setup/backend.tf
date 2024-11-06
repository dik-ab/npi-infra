resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-state-bucket"
  acl    = "private"
  
  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  tags = {
    Name        = "${var.project_name}-state-bucket"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "${var.project_name}-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-lock-table"
  }
}